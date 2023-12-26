describe Forecast, type: :model do
  subject(:forecast) { described_class.new }

  it { is_expected.to validate_presence_of(:temperature) }
  it { is_expected.to validate_presence_of(:observation_time) }

  describe '.nearest_to_timestamp_in_day' do
    subject {  described_class.nearest_to_timestamp_in_day(timestamp) }

    let(:time) { Time.current }
    let(:forecast_in_day) { create :forecast, temperature: 5.2, observation_time: time }
    let(:forecast_not_in_day) { create :forecast, temperature: 5.2, observation_time: time - 1.day }

    context 'WHEN nearest forecast by timestamp exists' do
      let(:timestamp) { (forecast_in_day.observation_time.to_i + 5.minutes).to_i }

      it 'returns forecasts within the day' do
        expect(subject).to contain_exactly(forecast_in_day)
      end
    end

    context 'WHEN nearest forecast by timestamp does NOT exist' do
      let(:timestamp) { (forecast_in_day.observation_time.to_i - 4.days).to_i }

      it 'returns forecasts within the day' do
        expect(subject).to eq []
      end
    end
  end
end
