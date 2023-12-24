module CrazyTrain
  class JWT
    HEADERS = { 'alg' => 'HS256', 'typ' => 'JWT' }.freeze

    def self.encode(payload, secret = CrazyTrain.config.secret)
      ::JWT.encode(payload, secret, 'HS256', HEADERS)
    end

    def self.decode(token, secret = CrazyTrain.config.secret)
      ::JWT.decode(token, secret, true, HEADERS)
    end
  end
end
