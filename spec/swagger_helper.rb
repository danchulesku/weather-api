# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'health_check.openapi.yaml' => {
      openapi: '3.0.1',
      servers: Rswag::Metadata.servers,
      info: Rswag::Metadata.info,
      components: {
        schemas: {
          HealthCheck: {
            show: {
              response: Schemas::HealthCheck::Show.response_body
            }
          }
        }
      }
    },

    'historical.openapi.yaml' => {
      openapi: '3.0.1',
      servers: Rswag::Metadata.servers,
      info: Rswag::Metadata.info,
      components: {
        schemas: {
          Weather: {
            Historical: {
              last_24_hours: {
                response: Schemas::Weather::Historical::Last24Hours.response_body
              },
              maximum: {
                response: Schemas::Weather::Historical::Maximum.response_body
              },
              minimum: {
                response: Schemas::Weather::Historical::Minimum.response_body
              },
              average: {
                response: Schemas::Weather::Historical::Average.response_body
              }
            }
          }
        }
      }
    },
    'weather.openapi.yaml' => {
      openapi: '3.0.1',
      servers: Rswag::Metadata.servers,
      info: Rswag::Metadata.info,
      components: {
        schemas: {
          Weather: {
            current: {
              response: Schemas::Weather::Current.response_body
            },
            by_time: {
              response: Schemas::Weather::ByTime.response_body
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
