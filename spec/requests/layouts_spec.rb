require 'rails_helper'

RSpec.describe "Layouts", type: :request do
  let!(:user) { create(:user) }

  describe "Layouts links" do
    it "show correct for logged-in and not-logged-in users" do
      get root_path
      expect(subject).to render_template('static_pages/home')
      expect(path).to eq(root_path)
      assert_select 'a', href: root_path, text: "sample app", count: 1
      assert_select 'a', href: root_path, text: "Home", count: 1
      assert_select 'a', href: help_path
      assert_select 'a', href: about_path
      assert_select 'a', href: contact_path
      assert_select 'a', href: login_path
      log_in_as(user)
      get root_path
      assert_select 'a', href: logout_path
      assert_select 'a', href: users_path
      assert_select 'a', href: user_path(user)
      assert_select 'a', href: edit_user_path(user)
    end
  end
end
