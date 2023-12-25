module Schemas
  module Weather
    module Historical
      module Minimum
        def self.response_body
          {
            body: {
              type: :object,
              properties: {
                min: { type: :number }
              }
            }
          }
        end
      end
    end
  end
end
