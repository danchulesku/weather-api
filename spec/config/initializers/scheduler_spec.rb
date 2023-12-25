require_relative '../../../config/initializers/scheduler'

describe 'Scheduler Configuration' do
  it 'runs scheduler' do
    expect_any_instance_of(Rufus::Scheduler).to receive(:in).with('1s')
    load 'config/initializers/scheduler.rb'
  end
end
