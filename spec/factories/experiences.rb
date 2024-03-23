FactoryBot.define do
  factory :experience do
    association :resume # Ensure this line correctly creates or associates a Resume instance
    company_name { 'MyString' }
    start_date { '2024-03-21' }
    end_date { '2024-03-21' }
    job_title { 'MyString' }
    description { 'MyText' }
    city { 'MyString' }
    province { 'MyString' }
    current_work { false }
  end
end
