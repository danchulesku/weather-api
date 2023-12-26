require 'swagger_helper'

describe 'historical weather', swagger_doc: 'historical.openapi.yaml', type: :request do
  let!(:forecast) { create :forecast, temperature: 10, observation_time: Time.now }

  path '/weather/historical' do
    get('show last 24 hours temperature per hour') do
      produces 'application/json'

      response('200', 'show last 24 hours temperature') do
        schema '$ref': '#/components/schemas/Weather/Historical/last_24_hours/response/body'
        run_test!
      end
    end
  end

  path '/weather/historical/max' do
    get('show maximum temp for last 24 hours') do
      produces 'application/json'

      response('200', 'show maximum temperature for last 24 hours') do
        schema '$ref': '#/components/schemas/Weather/Historical/maximum/response/body'
        run_test!
      end
    end
  end

  path '/weather/historical/min' do
    get('show minimum temp for last 24 hours') do
      produces 'application/json'

      response('200', 'show minimum temperature for last 24 hours') do
        schema '$ref': '#/components/schemas/Weather/Historical/minimum/response/body'
        run_test!
      end
    end
  end

  path '/weather/historical/avg' do
    get('show average temp for last 24 hours') do
      produces 'application/json'

      response('200', 'show average temperature for last 24 hours') do
        schema '$ref': '#/components/schemas/Weather/Historical/minimum/response/body'
        run_test!
      end
    end
  end
end
