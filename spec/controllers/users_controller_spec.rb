require 'spec_helper'
require "rails_helper"

describe UsersController do
  # describe "GET #new" do
  #   # subject { get '/signup' }
  #   it "should load new user page" do
  #     get new_user_path
  #     # expect(subject).to have_tag("title", text: full_title("Sign up"))
  #   end
  let!(:user) {create(:user, admin: true)}
  2.times do |n|
    let!(("user" + (n+1).to_s).to_sym) { create(:user, id: n+2,
                                            name: Faker::Name.name,
                                            email: "user-#{n + 1}@example.com",
                                            password: "password",
                                            password_confirmation: "password")
                                            }
  end
  describe "Not logged in user" do
    it "gets redirected when trying to visit edit page" do
      get :edit, params: { id: user }
      expect(flash).not_to be_empty
      expect(subject).to redirect_to(login_path)
      expect(subject.location).to eq(login_url)
    end

    it "gets redirected when trying to update user data" do
      patch :update, params: { id: user, user: { name: user.name, email: user.email } }
      expect(flash).not_to be_empty
      expect(subject).to redirect_to(login_path)
      expect(subject.location).to eq(login_url)
    end

    it "gets redirected away from user index page" do
      get :index
      expect(subject).to redirect_to(login_path)
    end
  end

  # => Moved to request/users_edits_spec.rb
  # describe "UsersController" do
  #   it "should redirect destroy, when user not logged in" do
  #     user_count_before = User.count
  #     delete :destroy, params: { id: user2 }
  #     expect(subject).to redirect_to(login_path)
  #     expect(response.location).to eq(login_url)
  #     expect(User.count).to eq(user_count_before)
  #   end
  #
  #   it "should redirect destroy, when not logged in as admin" do
  #     log_in_as(user2)
  #     user_count_before = User.count
  #     delete :destroy, params: { id: user }
  #     expect(User.count).to eq(user_count_before)
  #     expect(subject).to redirect_to(root_url)
  #   end
  # end

end


# test "should redirect destroy when not logged in" do
#     assert_no_difference 'User.count' do
#     delete :destroy, id: @user
#   end
#   assert_redirected_to login_url
# end
# test "should redirect destroy when logged in as a non-admin" do
#   log_in_as(@other_user)
#     assert_no_difference 'User.count' do
#     delete :destroy, id: @user
#   end
#   assert_redirected_to root_url
# end
