require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

run_from_console = defined?(IRB)

unless run_from_console
  scheduler.in '1s' do
    Weather::CollectJob.perform_now('Last24Hours')
    Weather::CollectJob.perform_now('CurrentHour')
  end
end
