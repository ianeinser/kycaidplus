module KYCAID
  module File
    extend Client

    def self.create(params)
      response = file_post("/files", params.slice(:file))
      new(JSON.parse(response.body))
    end

    def self.update(params)
      response = file_put("/files/#{params[:file_id]}", params.slice(:file, file_id).merge(sandbox: KYCAID.configuration.sandbox_mode))
      new(JSON.parse(response.body))
    end

    def initialize(response)
      super(response)
      self.raw_response = response
    end
	end
end
