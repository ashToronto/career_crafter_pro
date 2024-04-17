require 'faker'

User.where.not(role: :admin).destroy_all

users = Array.new(3) do
  User.create(
    email: Faker::Internet.email,
    password: 'password'
  )
end

themes = %w[free_default free_classic]
themes.each do |name|
  Theme.find_or_create_by(name: name)
end

users.each do |user|
  resume = user.resumes.create(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    country: Faker::Address.country,
    state: Faker::Address.state,
    phone_number: Faker::PhoneNumber.cell_phone,
    job_title: Faker::Job.title,
    theme_id: Theme.all.sample
  )

  # Seed experiences for the created resume
  2.times do
    resume.experiences.create(
      company_name: Faker::Company.name,
      start_date: Faker::Date.between(from: 5.years.ago, to: 2.years.ago),
      end_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
      job_title: Faker::Job.position,
      description: Faker::Lorem.paragraph(sentence_count: 2),
      country: Faker::Address.country,
      city: Faker::Address.city,
      province: Faker::Address.state,
      current_work: [true, false].sample,
      remote_work: [true, false].sample
    )
  end

  # Seed educations for the created resume
  2.times do
    resume.educations.create(
      institution_name: Faker::University.name,
      location: Faker::Address.city,
      field_of_study: Faker::Educator.subject,
      degree: Education.degrees.keys.sample, # Assuming Education model has enum for degrees
      start_date: Faker::Date.between(from: 5.years.ago, to: 3.years.ago),
      end_date: Faker::Date.between(from: 3.years.ago, to: 1.year.ago),
      currently_study: false
    )
  end

  # Specifically create an education with currently_study = true and no end_date
  resume.educations.create(
    institution_name: Faker::University.name,
    location: Faker::Address.city,
    field_of_study: Faker::Educator.subject,
    degree: Education.degrees.keys.sample, # Adjust based on the available degrees in your enum
    start_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
    currently_study: true,
    end_date: nil # Explicitly set end_date to nil for currently_study
  )

  3.times do
    resume.skills.create(
      name: Faker::Job.key_skill
    )
  end
end

puts 'SUCCESS: Database SEEDED'
