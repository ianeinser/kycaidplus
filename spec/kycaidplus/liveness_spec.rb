RSpec.describe KYCAIDPLUS::Liveness do
    subject { KYCAIDPLUS::Liveness }

    let(:valid_applicant) do
      {
        "type": "PERSON",
        "first_name": "John",
        "last_name": "Doe",
        "dob": "1970-10-25",
        "residence_country": "GB",
        "email": "john.doe@mail.com"
      }
    end

    let(:form_id) {"e26aeb4f012c19440f0ac11946e64da7787a"}
    let(:applicant_id) { "4d5ba38b00dcc94e0819bf77ea55846ee3c2" }
    let(:external_applicant_id) {"ID51B4464481"}
    let(:redirect_url) {"https://www.plutonext.com"}

    let(:form_params) do
    {
        applicant_id: applicant_id,
        external_applicant_id: external_applicant_id,
        redirect_url: redirect_url,
    }
    end

    let(:empty_response) { OpenStruct.new(body: '{}') }

    context "with prepared form" do

        before(:all) do
            KYCAIDPLUS.configure do |c|
                c.authorization_token = '3fed4d0900f5484a792b04541a541b483bda'
                c.sandbox_mode = true
                c.api_endpoint = 'https://api.kycaid.com'
                c.raise_errors = false
            end
        end

        it "pulled from dashboard" do

            VCR.use_cassette("liveness", record: :new_episodes) do
                #response = KYCAIDPLUS::Applicant.create(valid_applicant)

                #applicant_id = response.applicant_id
                #form_params[:applicant_id] = applicant_id

                response = KYCAIDPLUS::Liveness.create(form_params.merge(form_id: form_id))
                $stdout.puts response

            end

        end
            
    end

    

end
