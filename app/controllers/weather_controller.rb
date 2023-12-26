class WeatherController < ApplicationController
  def current
    render json: { temperature: Forecast.last.temperature }
  end

  def by_time
    temp = Forecast.nearest_to_timestamp_in_day(params[:timestamp]).first!&.temperature
    render json: { temperature: temp }
  end
end
