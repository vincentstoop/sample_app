require 'rails_helper'

RSpec.feature "UsersLogins", type: :feature do
  let(:user) {create(:user)}
  it "doesn't let you log in with incorrect information" do
    visit login_path
    expect(current_path).to eq(login_path)
    expect(page.title).to include(full_title("Log in"))
    fill_in "session_email", with: "invalid@email"
    fill_in "session_password", with: "foo"
    click_button "Log in"
    expect(current_path).to eq(login_path)
    expect(page.title).to include(full_title("Log in"))
    expect(page).to have_selector("div.alert.alert-danger")
    visit root_path
    expect(page).not_to have_selector("div.alert.alert-danger")
  end

  it "lets you login with valid information and logout" do
    visit login_path
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "Log in"
    expect(page).to have_selector(:css, 'a[href="' + login_path + '"]', count: 0)
    expect(page).to have_selector(:css, 'a[href="' + logout_path + '"]')
    expect(page).to have_selector(:css, 'a[href="' + user_path(user) + '"]')
    # expect(page.driver.status_code).to eq(200)
    # expect(page).to have_current_path(user_path(user))
    click_link("Log out")
    expect(page).to have_current_path(root_path)
    page.driver.delete logout_path
    visit root_path
    expect(page).to have_selector(:css, 'a[href="' + login_path + '"]')
    expect(page).to have_selector(:css, 'a[href="' + logout_path + '"]', count: 0)
    expect(page).to have_selector(:css, 'a[href="' + user_path(user) + '"]', count: 0)
  end
end
