require "application_system_test_case"

class TechniciansTest < ApplicationSystemTestCase
  setup do
    @technician = technicians(:one)
  end

  test "visiting the index" do
    visit technicians_url
    assert_selector "h1", text: "Technicians"
  end

  test "should create technician" do
    visit technicians_url
    click_on "New technician"

    fill_in "Name", with: @technician.name
    click_on "Create Technician"

    assert_text "Technician was successfully created"
    click_on "Back"
  end

  test "should update Technician" do
    visit technician_url(@technician)
    click_on "Edit this technician", match: :first

    fill_in "Name", with: @technician.name
    click_on "Update Technician"

    assert_text "Technician was successfully updated"
    click_on "Back"
  end

  test "should destroy Technician" do
    visit technician_url(@technician)
    click_on "Destroy this technician", match: :first

    assert_text "Technician was successfully destroyed"
  end
end
