require "test_helper"

class SpasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get spas_index_url
    assert_response :success
  end
end
