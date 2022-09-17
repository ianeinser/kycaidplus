module KYCAIDPLUS
  # Liveness is wrapper for KYCAID endpoints to perform liveness check.
  class Liveness < Response
    extend Client

    # Gets form url based on the template prepared in dashboard
    # * +:applicant_id+ - _mandatory_ The applicant’s unique identificator that received in response of create an applicant. It's supposed to use when need to create verification for exists applicant.
    # * +:external_applicant_id+ -_optional_  Custom identifier of the applicant, which is intended for binding the applicant in the customer and KYCAID systems.
    # * +:redirect_url+ -_mandatory_ The customer site URL, where applicant will be redirected after completing filling the form.
    #
    # Returns Response object, containing
    # * +form_id+ - _mandatory_ The form’s unique identificator.
    # * +form_url+ - _mandatory_ One-time URL to the verification form. This URL will be available until applicant will not complete the form.
    # * +verificiation_id+ - _mandatory_ The verification’s unique identificator.
    def self.create(params)

      protected_params = params.slice(:applicant_id, :external_applicant_id, :redirect_url)
      form_id = params[:form_id]

      respond(post("/forms/#{form_id}/urls", protected_params))

    end
  end
end