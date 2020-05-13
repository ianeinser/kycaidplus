module KYCAID
  module Client
    def conn
      @conn ||= Faraday.new(url: "#{KYCAID.configuration.api_endpoint}")
    end

    def multipart_conn
      @multipart_conn ||= Faraday.new(url: "#{KYCAID.configuration.api_endpoint}") do |faraday|
        faraday.request :multipart
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end

    def set_auth_header
      conn.authorization("Token", KYCAID.configuration.authorization_token)
    end

    def set_multipart_auth_header
      multipart_conn.authorization("Token", KYCAID.configuration.authorization_token)
    end

    def get(url, options={})
      set_auth_header
      conn.get(url, options.merge(sandbox: KYCAID.configuration.sandbox_mode))
    end

    def post(url, params={})
      set_auth_header
      conn.post(url, params.merge(sandbox: KYCAID.configuration.sandbox_mode))
    end

    def patch(url, params={})
      set_auth_header
      conn.patch(url, params.merge(sandbox: KYCAID.configuration.sandbox_mode))
    end

    def file_post(url, params={})
      set_multipart_auth_header
      multipart_conn.post(url, file_payload(params))
    end

    def file_put
      set_multipart_auth_header
      multipart_conn.put(url, file_payload(params))
    end

    def file_payload(params={})
      file = Faraday::UploadIO.new(
        params[:tempfile].path,
        params[:content_type],
        params[:original_filename]
      )
      payload = { :file => file }.merge(sandbox: KYCAID.configuration.sandbox_mode)
      payload
    end
  end
end
