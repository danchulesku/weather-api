module Weather
  class HistoricalController < ApplicationController
    def last_24_hours
      render json: {
        temps: Forecast.last(24).map { |f| { temperature: f.temperature, observation_time: f.observation_time } }
      }
    end

    def maximum
      render json: { max: Forecast.last(24).max_by(&:temperature)&.temperature }
    end

    def minimum
      render json: { min: Forecast.last(24).min_by(&:temperature)&.temperature }
    end

    def average
      render json: { avg: Forecast.last(24).map(&:temperature).sum / 24 }
    end
  end
end
