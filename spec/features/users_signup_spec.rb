require 'rails_helper'

RSpec.feature "Signup management", :type => :feature do
  let!(:user) {build(:user)}

  35.times do |n|
    let!(("user" + (n+1).to_s).to_sym) { build(:user, id: n+2,
                                            name: Faker::Name.name,
                                            email: "user-#{n + 1}@example.com",
                                            password: "password",
                                            password_confirmation: "password",
                                            activated: true,
                                            activated_at: Time.zone.now)
                                            }
  end

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
    # expect(page).to have_current_path(user_path(user))
  end
end
