module CommissionHub
  module Awin
    module Endpoints
      class Base < CommissionHub::Endpoint

        def call(request_params={})
          request_params = {
              headers: { "Authorization" => "Bearer #{api_token}" }
            }.deep_merge(request_params)
          connection.class.get(full_uri, request_params)
        end

        def api_token
          connection.settings.api_token
        end

      end

    end
  end
end
