require "application_system_test_case"

class DepartmentsTest < ApplicationSystemTestCase
  setup do
    @department = departments(:one)
  end

  test "visiting the index" do
    visit departments_url
    assert_selector "h1", text: "Departments"
  end

  test "creating a Department" do
    visit departments_url
    click_on "New Department"

    fill_in "Created at", with: @department.created_at
    fill_in "Disbanded at", with: @department.disbanded_at
    fill_in "Name", with: @department.name
    fill_in "Parent", with: @department.parent_id
    click_on "Create Department"

    assert_text "Department was successfully created"
    click_on "Back"
  end

  test "updating a Department" do
    visit departments_url
    click_on "Edit", match: :first

    fill_in "Created at", with: @department.created_at
    fill_in "Disbanded at", with: @department.disbanded_at
    fill_in "Name", with: @department.name
    fill_in "Parent", with: @department.parent_id
    click_on "Update Department"

    assert_text "Department was successfully updated"
    click_on "Back"
  end

  test "destroying a Department" do
    visit departments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Department was successfully destroyed"
  end
end
