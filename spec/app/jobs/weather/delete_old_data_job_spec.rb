describe Weather::DeleteOldDataJob, type: :job do
  let!(:old_forecasts) { create_list(:forecast, 48) }
  let!(:new_forecasts) { create_list(:forecast, 24, temperature: 40) }

  it 'destroys data' do
    expect { described_class.perform_now }.to change { Forecast.count }.from(72).to(24)
  end

  it 'does NOT destroy current data' do
    described_class.perform_now
    expect(Forecast.all.all? { |forecast| forecast.temperature == 40 }).to be true
  end
end
