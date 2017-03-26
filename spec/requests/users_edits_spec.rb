require 'rails_helper'

RSpec.describe "UsersEdits", type: :request do
  let!(:user) {create(:user)}
  let!(:other_user) {create(:user, id: 2, name: "Jan Smit", email: "jan@smit.nl", password: "password", password_confirmation: "password")}
  describe "GET /user/:id/edit" do
    it "works! (now write some real specs)" do
      log_in_as(user)
      get edit_user_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /user/:id/edit" do
    describe "unsuccessful edit" do
      it "renders the users/edit template" do
        log_in_as(user)
        get edit_user_path(user)
        patch user_path(user.id, user: { name: "",
                                          email: "foo@invalid",
                                          password: "foo",
                                          password_confirmation: "bar" })
        expect(subject).to render_template("users/edit")
      end
    end

    describe "successful edit" do
      it "updates the user data" do
        log_in_as(user)
        get edit_user_path(user)
        expect(subject).to render_template('users/edit')
        name = "Foo Bar"
        email = "foo@bar.com"
        patch user_path(user.id, user: { name: name,
                                          email: email,
                                          password: "",
                                          password_confirmation: "" })
        expect(flash).not_to be_empty
        expect(response.location).to eq(user_url(user))
        user.reload
        expect(user.name).to eq(name)
        expect(user.email).to eq(email)
      end
    end
  end

  describe "Logged in user" do
    it "gets redirected when trying to visit other users' edit page" do
      log_in_as(other_user)
      get edit_user_path(id: user)
      expect(flash).to be_empty
      expect(subject).to redirect_to(root_url)
      expect(response.location).to eq(root_url)
    end

    it "gets redirected when trying to update other users' data" do
      log_in_as(other_user)
      patch user_path id: user, user: { name: user.name, email: user.email }
      expect(flash).to be_empty
      expect(subject).to redirect_to(root_url)
      expect(response.location).to eq(root_url)
    end
  end

  describe "Not logged in user" do
    it "gets friendly forwarded to edit path upon logging in" do
      get edit_user_path(user)
      expect(session[:forwarding_url]).not_to be_empty
      log_in_as(user)
      expect(subject).to redirect_to edit_user_path(user)
      name = "Foo Bar"
      email = "foo@bar.com"
      patch user_path(user), params: { user: { name: name, email: email } }
      expect(flash).not_to be_empty
      expect(subject).to redirect_to user
      expect(session[:forwarding_url]).to eq(nil)
      user.reload
      expect(user.name).to eq(name)
      expect(user.email).to eq(email)
    end
  end

  describe "UsersController" do
    it "should redirect destroy, when user not logged in" do
      user_count_before = User.count
      delete user_path(user)
      expect(subject).to redirect_to(login_path)
      # expect(response.location).to eq(login_url)
      expect(User.count).to eq(user_count_before)
    end

    it "should redirect destroy, when not logged in as admin" do
      log_in_as(other_user)
      user_count_before = User.count
      delete user_path(user)
      expect(User.count).to eq(user_count_before)
      expect(subject).to redirect_to(root_url)
    end

    it "should not allow the admin attribute to be edited via the web" do
      log_in_as(other_user)
      expect(other_user.admin?).to eq(false)
      patch user_path(other_user), params: { user: { name: other_user.name,
                                           email: other_user.email,
                                           admin: true } }
      expect(other_user.reload.admin?).to eq(false)
    end

  end
end


# test "successful edit with friendly forwarding" do
# get edit_user_path(@user)
# log_in_as(@user)
# assert_redirected_to edit_user_path(@user)
# name = "Foo Bar"
# email = "foo@bar.com"
# patch user_path(@user), user: { name: name,
# email: email,
# password:
# "foobar",
# password_confirmation: "foobar" }
# assert_not flash.empty?
# assert_redirected_to @user
# @user.reload
# assert_equal @user.name, name
# assert_equal @user.email, email
# end
