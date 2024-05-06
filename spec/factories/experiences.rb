FactoryBot.define do
  factory :experience do
    association :resume # Ensure this line correctly creates or associates a Resume instance
    company_name { 'MyString' }
    start_date { 10.days.ago }
    end_date { 5.days.ago }
    job_title { 'MyString' }
    content { '<li>hekko world action text rich text trix</li>' }
    city { 'MyString' }
    province { 'MyString' }
    current_work { false }
  end
end
