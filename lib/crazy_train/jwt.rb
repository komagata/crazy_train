require 'jwt'

module CrazyTrain
  class JWT
    class << self
      HEADERS = { 'alg' => 'HS256', 'typ' => 'JWT' }.freeze

      def encode(payload, secret = CrazyTrain.config.secret)
        ::JWT.encode(payload, secret, 'HS256', HEADERS)
      end

      def decode(token, secret = CrazyTrain.config.secret)
        ::JWT.decode(token, secret, true, HEADERS)
      end

      def generate_jwt_secret
        SecureRandom.alphanumeric(32)
      end
    end

    attr_reader :raw_token,
                :secret,
                :raw_header,
                :raw_payload,
                :raw_signeture,
                :header,
                :payload,
                :signeture

    def initialize(raw_token, secret = CrazyTrain.config.secret)
      @raw_token = raw_token
      @secret = secret
      @header = nil
      @payload = nil
      @signeture = nil

      @raw_header, @raw_payload, @raw_signeture = @raw_token.split('.') if raw_token
    end

    def parse!; end

    def decode!
      @payload, @header = CrazyTrain::JWT.decode(@raw_token, @secret)
    end

    def role
      payload.fetch('role', nil)
    end

    def valid?
      @header && @payload
    end

    def payload_string
      JSON.generate(@payload)
    end
  end
end
