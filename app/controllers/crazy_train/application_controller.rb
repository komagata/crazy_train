require 'jwt'

module CrazyTrain
  class ApplicationController < ActionController::Base
    handle_api_errors

    before_action :verify_token
    before_action :setup_role
    after_action :teardown_role

    def verify_token
      @default_role = CrazyTrain.current_role
      @role = if jwt_token && jwt_payload && jwt_payload['iss'] == 'crazy_train'
                jwt_payload['role'] || CrazyTrain.config.authenticated_role
              else
                CrazyTrain.config.unauthorized_role
              end
      # set_db_configs!
    end

    def setup_role
      switch_role(@role)
    end

    def teardown_role
      switch_role(@default_role)
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
      {}
    end

    def other_payload
      jwt_payload.reject { %w[iss role].include? _1 }
    end

    def set_db_configs!
      other_payload.each do |k, v|
        CrazyTrain.set_db_config(k, v)
      end
    end
  end
end
