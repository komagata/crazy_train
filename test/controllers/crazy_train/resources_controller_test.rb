require 'test_helper'

module CrazyTrain
  class ResourcesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @token = CrazyTrain::JWT.encode(
        { 'iss' => 'crazy_train' }
      )

      @admin_token = CrazyTrain::JWT.encode(
        { 'iss' => 'crazy_train', 'role' => 'admin', 'user_id' => 1234 }
      )

      @headers = { 'Authorization' => "Bearer: #{@token}" }
      @admin_headers = { 'Authorization' => "Bearer: #{@admin_token}" }
    end

    test 'get announcements by authenticated' do
      get resources_url(resource: 'announcements'),
          headers: @headers

      assert_response :success

      actual = response.parsed_body.map { _1.slice('body') }
      expected = announcements.map { _1.slice('body') }

      assert_equal expected, actual
    end

    test 'can not get a announcement by anonymous' do
      announcement = Announcement.find_by(body: 'Announcement body 1')

      get resource_url(resource: 'announcements', id: announcement.id)

      assert_response :not_found
    end

    test 'get a announcement by authenticated' do
      announcement1 = announcements(:announcement1)

      get resource_url(resource: 'announcements', id: announcement1.id),
          headers: @headers

      assert_response :success
      resource = response.parsed_body

      assert_equal announcement1.body, resource['body']
    end

    test 'get users by admin' do
      get resources_url(resource: 'users'),
          headers: @admin_headers

      assert_response :success

      actual = response.parsed_body.map { _1.slice('nickname', 'email') }
      expected = users.map { _1.slice('nickname', 'email') }

      assert_equal expected, actual
    end

    test 'get a user by admin' do
      ozzy = users(:ozzy)
      get resource_url(resource: 'users', id: ozzy.id),
          headers: @admin_headers

      assert_response :success
      resource = response.parsed_body

      assert_equal ozzy.nickname, resource['nickname']
    end

    test 'can not create a announcement from anonymous' do
      body = 'new announcement body'
      post resources_url(resource: 'announcements'), params: { body: body }

      assert_response :internal_server_error
      assert_not_equal body, Announcement.last&.body
    end

    test 'create a announcement from admin' do
      body = 'new announcement body'
      post resources_url(resource: 'announcements'),
           params: { body: body },
           headers: @admin_headers

      assert_response :created
      assert_equal body, Announcement.last&.body
    end

    test 'can not update a announcement from anonymous' do
      announcement1 = announcements(:announcement1)
      body = 'updated announcement body'
      patch resources_url(resource: 'announcements', id: announcement1.id),
            params: { body: body }

      assert_response :not_found
      assert_not_equal body, Announcement.find_by(body: body)&.body
    end

    test 'update a announcement from admin' do
      announcement1 = announcements(:announcement1)
      body = 'new announcement body'
      patch resource_url(resource: 'announcements', id: announcement1.id),
            params: { body: body },
            headers: @admin_headers

      assert_response :no_content
      assert_equal body, Announcement.find(announcement1.id)&.body
    end

    test 'can not delete a announcement from anonymous' do
      announcement1 = announcements(:announcement1)
      delete resources_url(resource: 'announcements', id: announcement1.id)

      assert_response :not_found
      assert_includes Announcement.pluck(:id), announcement1.id
    end

    test 'delete a announcement from admin' do
      announcement1 = announcements(:announcement1)
      delete resource_url(resource: 'announcements', id: announcement1.id),
             headers: @admin_headers

      assert_response :no_content
      assert_not Announcement.find_by(id: announcement1.id)
    end
  end
end
