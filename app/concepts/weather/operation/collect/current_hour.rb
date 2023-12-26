module Weather
  module Operation
    module Collect
      class CurrentHour < Trailblazer::Operation
        step :validate
        step :fetch_data
        step :save
        left Shared::Operations::HandleErrors

        private

        def validate(ctx, params)
          ctx[:contract] = Weather::Contract::Base.new(OpenStruct.new(params))
          ctx[:contract].validate(params)
          ctx[:contract].errors.blank?
        end

        def fetch_data(ctx, params)
          response = HTTParty.get("#{params[:api_domain]}/currentconditions/v1/#{params[:city_code]}",
                                  query: { apikey: params[:api_key] })

          if response.success?
            ctx[:current_temperature] = response.parsed_response
          else
            ctx[:error] = "Something went wrong with foreign API #{response.parsed_response['Message']}"
            false
          end
        end

        def save(ctx, _params)
          Forecast.create!(
            temperature: ctx[:current_temperature].first['Temperature']['Metric']['Value'],
            observation_time: Time.parse(ctx[:current_temperature].first['LocalObservationDateTime'])
          )
        rescue StandardError
          ctx[:error] = 'Something went wrong with API DATA'
          false
        end
      end
    end
  end
end
