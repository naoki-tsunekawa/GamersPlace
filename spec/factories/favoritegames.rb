FactoryBot.define do
  factory :favoritegame do
    association :user
    association :game
  end
end
