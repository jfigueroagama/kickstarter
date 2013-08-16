FactoryGirl.define do
  factory :user do
    name                  "Michael Hartl"
    email                 "michael@rubyonrails.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end