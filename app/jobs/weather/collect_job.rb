module Weather
  class CollectJob < ApplicationJob
    queue_as :default

    def perform(collect_time_const)
      collect_weather_operation = Object.const_get "Weather::Operation::Collect::#{collect_time_const}"
      collect_weather_operation.call(
        {
          city_code: Rails.configuration.city_code,
          api_domain: Rails.configuration.foreign_weather_api_domain,
          api_key: Rails.configuration.foreign_weather_api_key
        }
      )
    end
  end
end
