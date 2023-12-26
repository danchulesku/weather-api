require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

run_from_console = defined?(IRB)

unless run_from_console
  scheduler.in '1s' do
    Weather::CollectJob.set(priority: 1).perform_later('Last24Hours')
    Weather::CollectJob.set(priority: 2).perform_later('CurrentHour')
  end

  scheduler.every '1hour' do
    Weather::CollectJob.perform_later('CurrentHour')
  end
end
