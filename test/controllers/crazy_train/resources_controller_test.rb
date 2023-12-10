require 'test_helper'

module CrazyTrain
  class ResourcesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @users = [
        { nickname: 'ozzy', email: 'ozzy@example.com', role: 'admin' },
        { nickname: 'randy', email: 'randy@example.com', role: 'anonymouse' },
        { nickname: 'brad', email: 'brad@example.com', role: 'anonymouse' },
        { nickname: 'geezer', email: 'geezer@example.com', role: 'anonymouse' },
        { nickname: 'zakk', email: 'zakk@example.com', role: 'anonymouse' }
      ]

      # Create initial users
      @users.each do |user|
        User.create!(user)
      end
    end

    test 'should get index' do
      get resources_url(resource: 'users')

      assert_response :success

      actual = response.parsed_body.map do |user|
        { nickname: user['nickname'], email: user['email'], role: user['role'] }
      end

      assert_equal @users, actual
    end

    test 'should get index with order' do
      get resources_url(resource: 'users', params: { order: 'nickname.asc,id.desc' })

      assert_response :success

      expected = @users.sort_by { |u| u[:nickname] }

      actual = response.parsed_body.map do |user|
        { nickname: user['nickname'], email: user['email'], role: user['role'] }
      end

      assert_equal expected, actual
    end

    test 'should get a resource' do
      expected = @users.find do |user|
        user[:nickname] == 'ozzy'
      end

      get resource_url(resource: 'users', id: 1)

      data = response.parsed_body
      actual = { nickname: data['nickname'], email: data['email'], role: data['role'] }

      assert_equal expected, actual
    end
  end
end
