module Schemas
  module HealthCheck
    module Show
      def self.response_body
        {
          body: {
            type: :object,
            properties: {
              status: { type: :string, example: 'ok' }
            }
          }
        }
      end
    end
  end
end
