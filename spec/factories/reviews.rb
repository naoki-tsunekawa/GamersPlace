FactoryBot.define do
  factory :review do
    user { nil }
    game { nil }
    content { "MyString" }
    score { 1 }
  end
end
