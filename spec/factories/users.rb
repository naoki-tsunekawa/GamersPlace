FactoryBot.define do
  factory :user do
    name { "Example User" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }

    factory :admin do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      admin { true }
    end

    factory :other_user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
    end
  end
end
