describe Weather::Operation::Collect::CurrentHour, type: :operation do
  let(:operation) { described_class.new }
  let(:ctx) { {} }

  describe 'contracts' do
    it_behaves_like 'weather contract'
  end

  describe '#fetch_data' do
    subject { operation.send(:fetch_data, ctx, params) }

    context 'WHEN params for API are valid', vcr: { cassette_name: 'current_hour/successful_request' } do
      let(:params) do
        {
          city_code: Rails.configuration.city_code,
          api_domain: Rails.configuration.foreign_weather_api_domain,
          api_key: 'valid_key'
        }
      end

      it { is_expected.to be_truthy }
    end

    context 'WHEN params for API are NOT valid', vcr: { cassette_name: 'current_hour/failed_request' } do
      let(:params) do
        {
          city_code: Rails.configuration.city_code,
          api_domain: Rails.configuration.foreign_weather_api_domain,
          api_key: 'invalid_api_key'
        }
      end

      it { is_expected.to be false }
    end
  end

  describe '#save' do
    subject { operation.send(:save, ctx, {}) }

    let(:ctx) { { current_temperature: data_from_api } }

    context 'WHEN data is valid' do
      let(:api_domain) { Rails.configuration.foreign_weather_api_domain }
      let(:url) { "#{api_domain}/currentconditions/v1/#{Rails.configuration.city_code}" }
      let(:api_query) { { apikey: 'valid_key' } }
      let(:data_from_api) do
        VCR.use_cassette('current_hour/successful_request') { HTTParty.get(url, query: api_query).parsed_response }
      end

      it { is_expected.to be_truthy }

      it 'creates new forecast' do
        expect { subject }.to change { Forecast.count }.by(1)
      end
    end

    context 'WHEN data is NOT valid' do
      let(:data_from_api) { nil }

      it { is_expected.to be false }

      it 'does NOT create new forecast' do
        expect { subject }.not_to(change { Forecast.count })
      end
    end
  end
end
