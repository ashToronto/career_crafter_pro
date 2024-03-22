require 'faker'

User.where.not(role: :admin).destroy_all

users = Array.new(3) do
  User.create(
    email: Faker::Internet.email,
    password: 'password'
  )
end

users.each do |user|
  resume = user.resumes.create(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    country: Faker::Address.country,
    state: Faker::Address.state,
    phone_number: Faker::PhoneNumber.cell_phone,
    job_title: Faker::Job.title
  )

  # Seed experiences for the created resume
  2.times do
    resume.experiences.create(
      company_name: Faker::Company.name,
      start_date: Faker::Date.between(from: 5.years.ago, to: 2.years.ago),
      end_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
      job_title: Faker::Job.position,
      description: Faker::Lorem.paragraph(sentence_count: 2),
      city: Faker::Address.city,
      province: Faker::Address.state,
      current_work: [true, false].sample
    )
  end

  # Specifically create an experience with current_work = true and no end_date
  resume.experiences.create(
    company_name: Faker::Company.name,
    start_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
    job_title: Faker::Job.position,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    city: Faker::Address.city,
    province: Faker::Address.state,
    current_work: true,
    end_date: nil # Explicitly set end_date to nil for current_work
  )
end

puts 'SUCCESS: Database SEEDED'
