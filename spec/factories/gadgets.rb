# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gadget do
    user
    sequence(:name) {|i| "gadget ##{i}"}
    description "gadget description"
  end
  
  factory :invalid_gadget, parent: :gadget do
    name nil
  end
end
