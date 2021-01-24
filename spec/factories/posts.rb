FactoryBot.define do
  factory :post do
    content { "post test" }
    association :user
    association :game
  end
end
