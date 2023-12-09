require "test_helper"

module CrazyTrain
  class TablesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    test "should get index" do
      get tables_url
      puts response.body
      assert_response :success
    end
  end
end
