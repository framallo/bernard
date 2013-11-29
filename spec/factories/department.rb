require 'faker'

FactoryGirl.define do 
  factory :department do
    name        Faker::Commerce.product_name
    pm_id       (0..8).to_a.sample
    uuid        Faker::Code.isbn
    deleted     false
  end
end
