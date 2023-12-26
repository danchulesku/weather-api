class Forecast < ApplicationRecord
  validates :temperature, presence: true
  validates :observation_time, presence: true

  def self.nearest_to_timestamp_in_day(time)
    time = time ? Time.at(time.to_i) : Time.at(0)
    Forecast.where(observation_time: time.beginning_of_day..time.end_of_day).order(observation_time: :desc)
  end
end
