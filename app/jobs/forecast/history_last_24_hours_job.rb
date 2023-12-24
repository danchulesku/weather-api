module Forecast
  class HistoryLast24HoursJob < ApplicationJob
    queue_as :default

    def perform
      Forecast::Operation::CollectLast24Hours.call(
        {
          city_code: Rails.configuration.city_code,
          api_domain: Rails.configuration.foreign_weather_api_domain,
          api_key: Rails.configuration.foreign_weather_api_key
        }
      )
      #TODO: SPECS
    end
  end
end
