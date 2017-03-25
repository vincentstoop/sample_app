FactoryGirl.define do
  factory :user do
    id                 1
    name               "Vincent Stoop"
    email              "validemail@somewhere.com"
    password           "password"
    password_confirmation "password"
  end
end
