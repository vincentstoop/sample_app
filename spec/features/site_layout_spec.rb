require 'rails_helper'

RSpec.feature "Site Layout", :type => :feature do
  before { visit root_path }

  it "contains links to other pages" do
    # expect(root_path).to have_tag('a')
    visit root_path
    expect(page).to have_selector(:css, 'a[href="' + root_path + '"]', count: 2)
    expect(page).to have_selector(:css, 'a[href="' + help_path + '"]')
    expect(page).to have_selector(:css, 'a[href="' + about_path + '"]')
    expect(page).to have_selector(:css, 'a[href="' + contact_path + '"]')
  end

  it "links to the correct Sign-up page" do
    visit root_path
    click_link("Sign up now!")
    expect(page.title).to include(full_title("Sign up"))
  end

  it "has the correct title on homepage" do
    visit root_path
    expect(page).to have_http_status(200)
    expect(page.title).to include(full_title())
  end

  it "has the correct title on Help page" do
    visit help_path
    expect(page).to have_http_status(200)
    expect(page.title).to include(full_title("Help"))
  end

  it "has the correct title on About page" do
    visit about_path
    expect(page).to have_http_status(200)
    expect(page.title).to include(full_title("About"))
  end

  it "has the correct title on Contact page" do
    visit contact_path
    expect(page).to have_http_status(200)
    expect(page.title).to include(full_title("Contact"))
  end
end
