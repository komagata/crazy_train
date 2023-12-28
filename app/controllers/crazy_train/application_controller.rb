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

      if bearer.nil?
        @role = CrazyTrain.config.unauthorized_role
        return
      end

      jwt = CrazyTrain::JWT.new(bearer)
      jwt.decode!

      @role =
        if jwt.valid?
          jwt.role || CrazyTrain.config.authenticated_role
        else
          CrazyTrain.config.unauthorized_role
        end

      CrazyTrain.setup_jwt_claims!(jwt.payload_string)
    end

    def setup_role
      switch_role(@role)
    end

    def teardown_role
      switch_role(@default_role)
    end

    private

    def bearer
      request.headers['Authorization']&.sub(/^Bearer: /, '')
    end
  end
end
