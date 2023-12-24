class Weather < ApplicationRecord
  validates :temperature, presence: true
  validates :observation_time, presence: true
  #TODO: SPECS
end
