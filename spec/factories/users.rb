FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.now } # Automatically confirm the user

    trait :candidate do
      role { 'candidate' }
    end

    trait :admin do
      role { 'admin' }
    end

    trait :employer do
      role { 'employer' }
    end
  end
end
