require "test_helper"

class WorkingPeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @working_period = working_periods(:one)
  end

  test "should get index" do
    get working_periods_url
    assert_response :success
  end

  test "should get new" do
    get new_working_period_url
    assert_response :success
  end

  test "should create working_period" do
    assert_difference('WorkingPeriod.count') do
      post working_periods_url, params: { working_period: { department_id: @working_period.department_id, end_at: @working_period.end_at, person_id: @working_period.person_id, start_at: @working_period.start_at } }
    end

    assert_redirected_to working_period_url(WorkingPeriod.last)
  end

  test "should show working_period" do
    get working_period_url(@working_period)
    assert_response :success
  end

  test "should get edit" do
    get edit_working_period_url(@working_period)
    assert_response :success
  end

  test "should update working_period" do
    patch working_period_url(@working_period), params: { working_period: { department_id: @working_period.department_id, end_at: @working_period.end_at, person_id: @working_period.person_id, start_at: @working_period.start_at } }
    assert_redirected_to working_period_url(@working_period)
  end

  test "should destroy working_period" do
    assert_difference('WorkingPeriod.count', -1) do
      delete working_period_url(@working_period)
    end

    assert_redirected_to working_periods_url
  end
end
