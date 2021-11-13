require "application_system_test_case"

class WorkingPeriodsTest < ApplicationSystemTestCase
  setup do
    @working_period = working_periods(:one)
  end

  test "visiting the index" do
    visit working_periods_url
    assert_selector "h1", text: "Working Periods"
  end

  test "creating a Working period" do
    visit working_periods_url
    click_on "New Working Period"

    fill_in "Department", with: @working_period.department_id
    fill_in "End at", with: @working_period.end_at
    fill_in "Person", with: @working_period.person_id
    fill_in "Start at", with: @working_period.start_at
    click_on "Create Working period"

    assert_text "Working period was successfully created"
    click_on "Back"
  end

  test "updating a Working period" do
    visit working_periods_url
    click_on "Edit", match: :first

    fill_in "Department", with: @working_period.department_id
    fill_in "End at", with: @working_period.end_at
    fill_in "Person", with: @working_period.person_id
    fill_in "Start at", with: @working_period.start_at
    click_on "Update Working period"

    assert_text "Working period was successfully updated"
    click_on "Back"
  end

  test "destroying a Working period" do
    visit working_periods_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Working period was successfully destroyed"
  end
end
