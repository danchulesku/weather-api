require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

run_from_console = defined?(IRB)

unless run_from_console
  scheduler.in '1s' do
    Forecast::Collect::Last24HoursJob.perform_now
  end
end
