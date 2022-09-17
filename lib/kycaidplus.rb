require "faraday"
require "json"
require "ostruct"

require "kycaidplus/version"
require "kycaidplus/configuration"
require "kycaidplus/client"
require "kycaidplus/response"
require "kycaidplus/applicant"
require "kycaidplus/file"
require "kycaidplus/document"
require "kycaidplus/address"
require "kycaidplus/verification"
require "kycaidplus/liveness"

# KYCAIDPLUS module contains wrappers around KYCAIDPLUS API.
# See https://kycaid.com/
module KYCAIDPLUS
  
  # Error is generic error used in this gem.
  # All defined errors are inherited from Error.
  class Error < StandardError; end

  # Unauthorized is raised when 403 status returned,
  # when request is correct but refuses to authorize it.
  # Check your token or contact KYCAIDPLUS support.
  class Unauthorized < Error; end

  class << self
    attr_accessor :configuration
  end

  # Coinfigure allows to change gem preferences. Check Configuration for the list of options.
  # ==== Example
  #
  # KYCAIDPLUS.configure do |c|
  #   c.authorization_token = '1MAR3SP3CTABL3t0k3N'
  #   c.sandbox_mode = false
  #   c.api_endpoint = 'https://api.kycaid.com/'
  #   c.raise_errors = true
  # end
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end
end
