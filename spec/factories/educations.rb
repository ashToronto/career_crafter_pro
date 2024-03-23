FactoryBot.define do
  factory :education do
    association :resume

    institution_name { 'MyString' }
    location { 'MyString' }
    field_of_study { 'MyString' }
    degree { 1 } # or use one of the defined enum keys for readability
    start_date { '2024-03-22' }
    end_date { '2024-03-22' }
    currently_study { false }
  end
end
