FactoryBot.define do
  factory :resume do
    user
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    country { Faker::Address.country }
    state { Faker::Address.state }
    phone_number { Faker::PhoneNumber.cell_phone }
    job_title { Faker::Job.title }
  end
end
