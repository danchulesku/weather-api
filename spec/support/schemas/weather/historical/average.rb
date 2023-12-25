module Schemas
  module Weather
    module Historical
      module Average
        def self.response_body
          {
            body: {
              type: :object,
              properties: {
                avg: { type: :number }
              }
            }
          }
        end
      end
    end
  end
end
