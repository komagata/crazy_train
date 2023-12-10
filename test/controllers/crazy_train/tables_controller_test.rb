require 'test_helper'

module CrazyTrain
  class TablesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test 'should get index' do
      get tables_url

      assert_response :success

      expected = %w[announcements users notes]

      assert_equal expected, response.parsed_body
    end
  end
end
