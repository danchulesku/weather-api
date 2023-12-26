require 'swagger_helper'

RSpec.describe 'weather', swagger_doc: 'weather.openapi.yaml', type: :request do
  let!(:forecast) { create :forecast, temperature: 10, observation_time: Time.now - 3.days }

  path '/weather/current' do
    get('show current temperature') do
      produces 'application/json'

      response('200', 'show current temperature') do
        schema '$ref': '#/components/schemas/Weather/current/response/body'
        run_test!
      end
    end
  end

  path '/weather/by_time' do
    get('show nearest temperature in day by timestamp') do
      produces 'application/json'

      parameter name: :timestamp, in: :query, type: :string

      context 'WHEN forecast with timestamp exists' do
        let(:timestamp) { forecast.observation_time.beginning_of_day.to_i }

        response('200', 'show nearest temperature in day by timestamp') do
          schema '$ref': '#/components/schemas/Weather/by_time/response/body'
          run_test!
        end
      end

      context 'WHEN forecast with timestamp does NOT exist' do
        let(:timestamp) { (forecast.observation_time.beginning_of_day - 1.day).to_i }

        response('404', 'render 404 with nil') do
          schema '$ref': '#/components/schemas/Weather/by_time/response/error'
          run_test!
        end
      end
    end
  end
end
