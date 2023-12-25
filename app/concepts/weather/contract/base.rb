module Weather
  module Contract
    class Base < Reform::Form
      property :city_code
      property :api_domain
      property :api_key

      validates :city_code, :api_domain, :api_key, presence: true
    end
  end
end
