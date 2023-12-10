module CrazyTrain
  class JWT
    HEADERS = { 'alg' => 'HS256', 'typ' => 'JWT' }.freeze

    def self.encode(payload, secret)
      ::JWT.encode(payload, secret, 'HS256', HEADERS)
    end

    def self.decode(token, secret)
      ::JWT.decode(token, secret, true, HEADERS)
    end
  end
end
