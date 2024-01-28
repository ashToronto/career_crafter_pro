require 'faker'

User.where.not(role: :admin).destroy_all

users = Array.new(3) {
  User.create(
    email: Faker::Internet.email,
    password: 'password'
    )
  }

User.all.each do |user|
  user.resumes.create(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    country: Faker::Address.country,
    state: Faker::Address.state,
    phone_number: Faker::PhoneNumber.cell_phone,
    job_title: Faker::Job.title
  )
end

puts 'SUCCESS Database SEEDED'
