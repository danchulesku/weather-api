module Schemas
  module Weather
    module Historical
      module Last24Hours
        def self.response_body
          {
            body: {
              type: :object,
              properties: {
                temps: {
                  type: :array,
                  items: {
                    type: :object,
                    properties: {
                      temperature: { type: :number },
                      observation_time: { type: :string, format: :date_time }
                    }
                  }
                }
              }
            }
          }
        end
      end
    end
  end
end
