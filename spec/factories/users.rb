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
  end
end
