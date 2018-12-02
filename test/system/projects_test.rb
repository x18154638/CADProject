require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  setup do
    @events = events(:one)
  end

  test "visiting the index" do
    visit events_url
    assert_selector "h1", text: "Events"
  end

  test "creating an Event" do
    visit events_url
    click_on "New Event"

    fill_in "Description", with: @event.description
    fill_in "Name", with: @event.name
    click_on "Create Event"

    assert_text "Event was successfully created"
    click_on "Back"
  end

  test "updating an Event" do
    visit events_url
    click_on "Edit", match: :first

    fill_in "Description", with: @event.description
    fill_in "Name", with: @event.name
    click_on "Update Event"

    assert_text "EVent was successfully updated"
    click_on "Back"
  end

  test "destroying an Event" do
    visit events_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Event was successfully destroyed"
  end
end
