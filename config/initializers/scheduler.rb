require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

run_not_from_console = !defined?(IRB)
#TODO: напиши тесты

if run_not_from_console
  scheduler.in '1s' do
    Forecast::HistoryLast24HoursJob.perform_now
  end
end
