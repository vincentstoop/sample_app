require 'rails_helper'

RSpec.feature "Signup management", :type => :feature do
  let!(:user) {build(:user)}
  it "doesn't allow signup with invalid information" do
    # let user = User.new(name: "", email: "email@invalid",
                        # password: "foo", password_confirmation: "bar" )
    user_count = User.count
    visit signup_path
    fill_in "user_name", with: ""
    fill_in "user_email", with: "invalid@email"
    fill_in "user_password", with: "foo"
    fill_in "user_password_confirmation", with: "bar"
    click_button "Create my account"
    expect(user_count).to eq(User.count)
  end

  it "allows signup with valid information" do
    user_count = User.count
    visit signup_path
    fill_in "user_name", with: user.name
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password
    click_button "Create my account"
    expect(User.count).to eq(user_count + 1)
    # expect(page).to have_text("Welcome to the sample app, #{user.name}")
    # expect(page.title).to eq(full_title(user.name))
    expect(page).to have_current_path(user_path(user))
    # click_link("Log out")
    # expect(page).to have_current_path(root_path)
  end
end
