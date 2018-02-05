FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email 'neville@lee.com'
    password '1234'
  end
end
