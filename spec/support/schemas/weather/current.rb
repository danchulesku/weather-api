module Schemas
  module Weather
    module Current
      def self.response_body
        {
          body: {
            type: :object,
            properties: {
              temperature: { type: :number }
            }
          }
        }
      end
    end
  end
end
