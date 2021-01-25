FactoryBot.define do
  factory :post do
    content { "post test" }
    created_at { 10.minutes.ago }
    association :user
    association :game

    trait :yesterday do
      content { "yesterday" }
      created_at { 1.day.ago }
    end

    trait :day_before_yesterday do
      content { "day_before_yesterday" }
      created_at { 2.days.ago }
    end

    trait :now do
      content { "now!" }
      created_at { Time.zone.now }
    end

    factory :delete_post do
      content { "Hello new game" }
    end
  end
end
