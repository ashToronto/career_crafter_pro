FactoryBot.define do
  factory :education do
    association :resume

    institution_name { 'MyString' }
    location { 'MyString' }
    field_of_study { 'MyString' }
    degree { 1 } # or use one of the defined enum keys for readability
    start_date { 10.days.ago }
    end_date { 5.days.ago }
    currently_study { false }
  end
end
