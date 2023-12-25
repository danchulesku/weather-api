class Forecast < ApplicationRecord
  validates :temperature, presence: true
  validates :observation_time, presence: true
end
