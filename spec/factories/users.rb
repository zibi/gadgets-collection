# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|i| "user#{i}@example.com"}
    password "testtest1234"
    password_confirmation "testtest1234"
  end
end
