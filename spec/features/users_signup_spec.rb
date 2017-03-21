require 'rails_helper'

RSpec.feature "Signup management", :type => :feature do
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
end
