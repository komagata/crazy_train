require 'jwt'

module CrazyTrain
  class ApplicationController < ActionController::Base
    handle_api_errors
    before_action :verify_token

    def verify_token
      @role = if jwt_token && jwt_payload && jwt_payload['iss'] == 'crazy_train'
                'authenticated'
              else
                'anonymous'
              end
      switch_role(@role)
    end

    def switch_role(role)
      ActiveRecord::Base.connection.execute("SET ROLE #{role};")
    end

    def jwt_token
      request.headers['Authorization'].split.last
    rescue StandardError
      ''
    end

    def jwt_payload
      CrazyTrain::JWT.decode(jwt_token, CrazyTrain.config.secret).first
    rescue StandardError
      ''
    end
  end
end
