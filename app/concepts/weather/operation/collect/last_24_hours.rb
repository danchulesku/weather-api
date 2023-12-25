module Weather
  module Operation
    module Collect
      class Last24Hours < Trailblazer::Operation
        step :validate
        step :fetch_data
        step :prepare_data
        step :save
        left :handle_errors

        private

        def validate(_ctx, params)
          params[:city_code] && params[:api_domain] && params[:api_key] || false
        end

        def fetch_data(ctx, params)
          response = HTTParty.get("#{params[:api_domain]}/currentconditions/v1/#{params[:city_code]}/historical/24",
                                  query: { apikey: params[:api_key] })

          if response.success?
            ctx[:temperature_24_hours] = response.parsed_response
          else
            ctx[:error] = "Something went wrong with foreign API #{response.parsed_response['Message']}"
            false
          end
        end

        def prepare_data(ctx, _params)
          ctx[:temperature_24_hours] = ctx[:temperature_24_hours].map do |hour|
            {
              temperature: hour['Temperature']['Metric']['Value'],
              observation_time: Time.parse(hour['LocalObservationDateTime']),
              created_at: Time.now,
              updated_at: Time.now
            }
          end.reverse!
        end

        def save(ctx, _params)
          Forecast.insert_all(ctx[:temperature_24_hours])
        rescue StandardError
          ctx[:error] = 'Something went wrong with API DATA'
          false
        end

        def handle_errors(ctx, _params)
          puts "ERROR: #{ctx[:error]}"
          exit!
        end
      end
    end
  end
end
