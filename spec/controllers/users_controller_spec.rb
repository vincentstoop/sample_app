require 'spec_helper'
require "rails_helper"

describe UsersController do
  # describe "GET #new" do
  #   # subject { get '/signup' }
  #   it "should load new user page" do
  #     get new_user_path
  #     # expect(subject).to have_tag("title", text: full_title("Sign up"))
  #   end
  let!(:user) {create(:user)}
  let!(:other_user) {create(:user, id: 2, name: "Jan Smit", email: "jan@smit.nl", password: "password", password_confirmation: "password")}
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

  # describe "Logged in user" do
    # it "gets redirected when trying to visit other users' edit page" do
    #   log_in_as(other_user)
    #   get :edit, params: { id: user }
    #   expect(flash).to be_empty
    #   expect(subject).to redirect_to(root_url)
    #   expect(subject.location).to eq(root_url)
    #
    # end

  #   it "gets redirected when trying to update other users' data" do
  #     log_in_as(other_user)
  #     patch :update, params: { id: user, user: { name: user.name,
  #                                                email: user.email } }
  #     expect(flash).to be_empty
  #     expect(subject).to redirect_to(root_url)
  #     expect(subject.location).to eq(root_url)
  #   end
  # end
end
