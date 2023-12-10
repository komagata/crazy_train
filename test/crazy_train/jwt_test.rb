require 'test_helper'

module CrazyTrain
  class JWTTest < ActiveSupport::TestCase
    setup do
      @payload = { 'iss' => 'crazy_train' }.freeze
      @headers = { 'alg' => 'HS256', 'typ' => 'JWT' }.freeze
      @secret = 'a' * 32
      @token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJjcmF6eV90cmFpbiJ9.tUAwhK5t_UOqDLubyZg1fEt4Vl-w4pyur6vrdSjqiBI'
    end

    test '.encode' do
      token = CrazyTrain::JWT.encode(@payload, @secret)

      assert_equal @token, token
    end

    test '.decode' do
      payload, headers = CrazyTrain::JWT.decode(@token, @secret)

      assert_equal @payload, payload
      assert_equal @headers, headers
    end
  end
end
