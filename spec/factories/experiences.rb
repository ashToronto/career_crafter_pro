FactoryBot.define do
  factory :experience do
    association :resume # Ensure this line correctly creates or associates a Resume instance
    company_name { 'Test Company' }
    start_date { 10.days.ago }
    end_date { 5.days.ago }
    job_title { 'Developer' }
    content { '<li>"Worked on various projects"</li>' }
    city { 'New York' }
    province { 'NY' }
    country { 'USA' }
    current_work { false }
    remote_work { false }
  end
end
