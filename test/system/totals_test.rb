require "application_system_test_case"

class TotalsTest < ApplicationSystemTestCase
  setup do
    @total = totals(:one)
  end

  test "visiting the index" do
    visit totals_url
    assert_selector "h1", text: "Totals"
  end

  test "creating a Total" do
    visit totals_url
    click_on "New Total"

    click_on "Create Total"

    assert_text "Total was successfully created"
    click_on "Back"
  end

  test "updating a Total" do
    visit totals_url
    click_on "Edit", match: :first

    click_on "Update Total"

    assert_text "Total was successfully updated"
    click_on "Back"
  end

  test "destroying a Total" do
    visit totals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Total was successfully destroyed"
  end
end
