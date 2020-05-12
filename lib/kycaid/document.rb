module KYCAID
  module Document
    extend Client

    def self.create(params)
      protected_params = params.slice(:applicant_id, :type, :document_number, :issue_date, :expiry_date, :front_side_id, :back_side_id)
      response = post("/documents", protected_params)
      new(JSON.parse(response.body))
    end

    def self.patch(applicant_id)
      protected_params = params.slice(:document_id, :applicant_id, :type, :document_number, :issue_date, :expiry_date, :front_side_id, :back_side_id)
      response = get("/documents/#{document_id}", protected_params)
      new(JSON.parse(response.body))
    end

    def initialize(response)
      super(response)
      self.raw_response = response
    end
	end
end
