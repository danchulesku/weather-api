module Rswag
  module Metadata
    def self.info
      {
        title: 'Weather API',
        version: 'v1'
      }
    end

    def self.servers
      [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ]
    end
  end
end
