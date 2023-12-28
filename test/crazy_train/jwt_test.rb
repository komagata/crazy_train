require 'test_helper'

module CrazyTrain
  class JWTTest < ActiveSupport::TestCase
    setup do
      @headers = { 'alg' => 'HS256', 'typ' => 'JWT' }.freeze
      @payload = { 'iss' => 'crazy_train' }.freeze
      @secret = '0123456789'
      @token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJjcmF6eV90cmFpbiJ9.a-9Uf4KIyYpOIGODLc5pXP2bY3DHQ-lNtmE-RK8sWgo'
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

    test '.decode!' do
      jwt = ::CrazyTrain::JWT.new(@token, @secret)
      jwt.decode!

      assert_equal @payload, jwt.payload
    end
  end
end
