require 'rails_helper'

describe User do
  let(:user) {User.new(name: "Example User", email: "user@example.com",
                   password: "foobar", password_confirmation: "foobar")}

  it "should be valid" do
    expect(user).to be_valid
  end

  it "should have a name" do
    user.name = "   "
    expect(user).not_to be_valid
  end

  it "should not have a name longer than 50 characters" do
    user.name = "a" * 50
    expect(user).to be_valid
    user.name = "a" * 51
    expect(user).not_to be_valid
  end

  it "should have an email address" do
    user.email = "      "
    expect(user).not_to be_valid
  end

  it "should not have an email address longer than 255 characters" do
    user.email = "a" * 243 + "@example.com"
    expect(user).to be_valid
    user.email = "a" * 244 + "@example.com"
    expect(user).not_to be_valid
  end

  it "should accept a valid email address through validation" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  it "should reject invalid email addresses through validation" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).not_to be_valid
    end
  end

  it "should have a unique email address" do
    duplicate_user = user.dup
    duplicate_user.email = duplicate_user.email.upcase
    user.save
    expect(duplicate_user).not_to be_valid
  end

  it "should have a password with a minimum of 6 characters" do
    user.password = user.password_confirmation = "a" * 6
    expect(user).to be_valid
    user.password = user.password_confirmation = "a" * 5
    expect(user).not_to be_valid
  end

end
