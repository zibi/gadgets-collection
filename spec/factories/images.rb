# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    gadget
    sequence(:title) { |i| "image #{i}" }
    sequence(:content_file_name) { |i| "test#{i}.jpeg" }
    content_file_size 1024
    content_content_type 'image'
  end
end
