module Schemas
  module Weather
    module ByTime
      def self.response_body
        {
          body: {
            type: :object,
            properties: {
              temperature: { type: :number }
            }
          },
          error: {
            type: :object,
            properties: {
              error: { type: :string }
            }
          }
        }
      end
    end
  end
end
