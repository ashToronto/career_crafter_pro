FactoryBot.define do
  factory :resume do
    user
    email { Faker::Internet.email }
    first_name { 'Adam' }
    last_name { 'Sandler' }
    country { Faker::Address.country }
    state { Faker::Address.state }
    phone_number { Faker::PhoneNumber.cell_phone }
    job_title { Faker::Job.title }
  end
end
