module Schemas
  module Weather
    module Historical
      module Maximum
        def self.response_body
          {
            body: {
              type: :object,
              properties: {
                max: { type: :number }
              }
            }
          }
        end
      end
    end
  end
end
