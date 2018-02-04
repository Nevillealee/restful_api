FactoryBot.define do
  factory :item do
    name {Faker::DragonBall.character}
    done false
    agenda_id nil
  end
end
