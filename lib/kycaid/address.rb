module KYCAID
  module Address
    extend Client

    def self.create(params)
      protected_params = params.slice(:type, :country, :state_or_province, :city, :postal_code, :street_name, :building_number)
      response = post("/addresses", protected_params)
      new(JSON.parse(response.body))
    end

    def self.fetch(params)
      protected_params = params.slice(:address_id, :country, :state_or_province, :city, :postal_code, :street_name, :building_number)
      response = patch("/addresses/#{address_id}", protected_params)
      new(JSON.parse(response.body))
    end

    def initialize(response)
      super(response)
      self.raw_response = response
    end
	end
end
