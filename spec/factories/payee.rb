require 'faker'

FactoryGirl.define do
  factory :payee do 
    name  Faker::Name.name
    deleted   false
    pm_id     (0..8).to_a.sample
    latitude  Faker::Address.latitude
    longitude Faker::Address.longitude
    uuid      Faker::Code.isbn

  end
end
