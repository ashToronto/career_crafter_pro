FactoryBot.define do
  factory :resume do
    user { nil }
    first_name { 'John' }
    last_name { 'Doe' }
    country { 'Canada' }
    state { 'Ontario' }
    phone_number { '4165693279' }
    email { 'JohnDoe@gmail.com' }
    job_title { 'Software Engineer' }
  end
end
