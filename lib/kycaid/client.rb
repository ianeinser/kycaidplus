module KYCAID
  module Client
    def conn
      @conn ||= Faraday.new(url: "#{KYCAID.configuration.api_endpoint}")
    end

    def set_auth_header
      conn.authorization("Token", KYCAID.configuration.authorization_token)
    end

    def get(url, options={})
      set_auth_header
      conn.get(url, options)
    end

    def post(url, params={})
      set_auth_header
      conn.post(url, params)
    end

    def patch(url, params={})
      set_auth_header
      conn.patch(url, params)
    end
  end
end
