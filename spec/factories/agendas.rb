FactoryBot.define do
  #wrap faker methods in a block to ensure unique data for ever agenda record
  factory :agenda do
    title {Faker::Lorem.word}
    created_by {Faker::Number.number(10)}
  end
end
