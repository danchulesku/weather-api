describe Weather::Operation::Collect::Last24Hours, type: :operation do
  let(:operation) { described_class.new }
  let(:ctx) { {} }

  describe 'contracts' do
    subject { operation.send(:validate, ctx, params) }

    context 'WHEN params are valid' do
      let(:params) { { city_code: 'code', api_domain: 'domain', api_key: 'key' } }

      it { is_expected.to be_truthy }
    end

    context 'WHEN params are invalid' do
      let(:params) { { city_code: nil, api_domain: 'domain', api_key: 'key' } }

      it { is_expected.to be false }
    end
  end

  describe '#fetch_data' do
    subject { operation.send(:fetch_data, ctx, params) }

    context 'WHEN params for API are valid', vcr: { cassette_name: 'last24_hours/successful_request' } do
      let(:params) do
        {
          city_code: Rails.configuration.city_code,
          api_domain: Rails.configuration.foreign_weather_api_domain,
          api_key: 'valid_key'
        }
      end

      it { is_expected.to be_truthy }
    end

    context 'WHEN params for API are NOT valid', vcr: { cassette_name: 'last24_hours/failed_request' } do
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

  describe '#prepare_data' do
    subject { operation.send(:prepare_data, ctx, {}) }

    let(:ctx) { { temperature_24_hours: data_from_api } }
    let(:api_domain) { Rails.configuration.foreign_weather_api_domain }
    let(:url) { "#{api_domain}/currentconditions/v1/#{Rails.configuration.city_code}/historical/24" }
    let(:api_query) { { apikey: 'valid_key' } }
    let(:freeze_time) { Time.now }
    let(:data_from_api) do
      VCR.use_cassette('last24_hours/successful_request') { HTTParty.get(url, query: api_query).parsed_response }
    end

    let(:correct_format_sample) do
      {
        temperature: data_from_api.first['Temperature']['Metric']['Value'],
        observation_time: Time.parse(data_from_api.first['LocalObservationDateTime']),
        created_at: freeze_time,
        updated_at: freeze_time
      }
    end

    before { Timecop.freeze(freeze_time) }

    it 'do NOT lose hours' do
      expect(subject.size).to eq(24)
    end

    it 'parses data to correct format' do
      expect(subject.last).to eq(correct_format_sample)
    end
  end

  describe '#save' do
    subject { operation.send(:save, ctx, {}) }

    let(:ctx) { { temperature_24_hours: data_sample } }

    context 'WHEN data is valid' do
      let(:data_sample) { [{ temperature: 2.3, observation_time: Time.now, created_at: Time.now, updated_at: Time.now }] }

      it { is_expected.to be_truthy }

      it 'creates new forecast' do
        expect { subject }.to change { Forecast.count }.by(1)
      end
    end

    context 'WHEN data is NOT valid' do
      let(:data_sample) { [{ temperature: nil, observation_time: Time.now, created_at: nil, updated_at: Time.now }] }

      it { is_expected.to be false }

      it 'does NOT create new forecast' do
        expect { subject }.not_to(change { Forecast.count })
      end
    end
  end
end
