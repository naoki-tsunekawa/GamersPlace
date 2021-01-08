FactoryBot.define do
  factory :user do
    name { "Example User" }
    email { "user@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }

    # FactoryBot.create(:user, :admin)の形で呼び出せる
    trait :admin do
      admin { true }
    end

    factory :other_user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
    end
  end
end
