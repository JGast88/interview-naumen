require "test_helper"

class ActivePeriodsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get active_periods_create_url
    assert_response :success
  end
end
