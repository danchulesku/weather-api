require 'swagger_helper'

RSpec.describe 'health_check', swagger_doc: 'health_check.openapi.yaml', type: :request do
  path '/health' do
    get('show health_check') do
      produces 'application/json'

      response('200', 'show API health') do
        schema '$ref': '#/components/schemas/HealthCheck/show/response/body'

        run_test! do |response|
          expect(JSON.parse(response.body, symbolize_names: true)).to eq({ status: 'ok' })
        end
      end
    end
  end
end
