require 'jwt'

module CrazyTrain
  class ApplicationController < ActionController::Base
    include CrazyTrain::Role

    handle_api_errors

    before_action :verify_token
    before_action :setup_role
    after_action :teardown_role

    def verify_token
      @default_role = current_role
      @role = if jwt_token && jwt_payload
                jwt_payload['role'] || CrazyTrain.config.authenticated_role
              else
                CrazyTrain.config.unauthorized_role
              end

      payload_string = JSON.generate(jwt_payload)
      CrazyTrain.setup_jwt_claims!(payload_string)
    end

    def setup_role
      switch_role(@role)
    end

    def teardown_role
      switch_role(@default_role)
    end

    def jwt_token
      request.headers['Authorization'].split.last
    rescue StandardError
      nil
    end

    def jwt_payload
      CrazyTrain::JWT.decode(jwt_token, CrazyTrain.config.secret).first
    rescue StandardError
      nil
    end
  end
end
