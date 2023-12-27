require 'jwt'

module CrazyTrain
  class JWT
    HEADERS = { 'alg' => 'HS256', 'typ' => 'JWT' }.freeze

    def self.encode(payload, secret = CrazyTrain.config.secret)
      ::JWT.encode(payload, secret, 'HS256', HEADERS)
    end

    def self.decode(token, secret = CrazyTrain.config.secret)
      ::JWT.decode(token, secret, true, HEADERS)
    end

    def self.generate_token(payload_string)
      payload = JSON.parse(payload_string || '{}')
      encode(payload)
    end

    def self.generate_jwt_secret
      SecureRandom.alphanumeric(32)
    end
  end
end
