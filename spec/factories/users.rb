FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.now } # Automatically confirm the user

    role { :candidate }

    trait :admin do
      role { :admin }
    end

    trait :confirmed do
      confirmed_at { Time.now }
    end

    trait :unconfirmed do
      confirmed_at { nil }
    end
  end
end
