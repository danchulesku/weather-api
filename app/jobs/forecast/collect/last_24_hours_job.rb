module Forecast
  module Collect
    class Last24HoursJob < ApplicationJob
      queue_as :default

      def perform
        Forecast::Operation::Collect::Last24Hours.call(
          {
            city_code: Rails.configuration.city_code,
            api_domain: Rails.configuration.foreign_weather_api_domain,
            api_key: Rails.configuration.foreign_weather_api_key
          }
        )
      end
    end
  end
end
