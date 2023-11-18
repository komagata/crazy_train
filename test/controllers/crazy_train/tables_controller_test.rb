require "test_helper"

module CrazyTrain
  class TablesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get tables_index_url
      assert_response :success
    end
  end
end
