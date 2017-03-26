require 'rails_helper'

RSpec.describe "UsersIndex", type: :request do
  let!(:user) { create(:user, admin: true) }

  35.times do |n|
    let!(("user" + (n+1).to_s).to_sym) { create(:user, id: n+2,
                                            name: Faker::Name.first_name,
                                            email: "user-#{n + 1}@example.com",
                                            password: "password",
                                            password_confirmation: "password")
                                            }
  end

  describe "GET users/index" do
    it "works! (now write some real specs)" do
      get users_path
      expect(subject).to redirect_to(login_path)
      log_in_as(user)
      expect(response.location).to eq(users_url)
    end

    it "has pagination" do
      log_in_as(user)
      get users_path
      expect(subject).to render_template('users/index')
      expect(response).to have_http_status(200)
      expect(response.body).to include('div class="pagination"')
      User.paginate(page: 1).each do |user|
        expect(response.body).to include('a href="' + user_path(user) + '">' + user.name)
      end
    end
  end

  it "shows delete links and pagination when logged in as admin" do
    log_in_as(user)
    get users_path
    before_user_count = User.count
    expect(subject).to render_template('users/index')
    # expect(response.body).to include('div class="pagination"')
    assert_select 'div', class: 'pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a', href: user_path(user), text: user.name
      assert_select 'a', href: user_path(user), text: "delete user #{user.id}",
                                                method: :delete unless user.admin?
    end
    delete user_path(user5)
    expect(User.count).to eq(before_user_count - 1)
  end

  it "shows no delete links when logged in as non-admin" do
    log_in_as(user4)
    get users_path
    assert_select 'a', text: 'delete', count: 0
    # expect(response.body).not_to include('a data-confirm="You sure?" rel="nofollow" data-method="delete" href="/users/')
  end
end
