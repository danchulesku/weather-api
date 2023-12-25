describe Weather::Collect::Last24HoursJob, type: :job do
  let(:city_code) { 'your_city_code' }
  let(:api_domain) { 'your_api_domain' }
  let(:api_key) { 'your_api_key' }

  before do
    Rails.application.config.city_code = city_code
    Rails.application.config.foreign_weather_api_domain = api_domain
    Rails.application.config.foreign_weather_api_key = api_key
  end

  it '#perform' do
    expect(Weather::Operation::Collect::Last24Hours).to receive(:call).with(
      {
        city_code:,
        api_domain:,
        api_key:
      }
    )

    described_class.perform_now
  end
end
