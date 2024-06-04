FactoryBot.define do
  factory :education do
    association :resume

    institution_name { 'Test University' }
    location { 'Test City' }
    field_of_study { 'Computer Science' }
    degree { :masters }
    start_date { Date.yesterday }
    end_date { Date.today }
    currently_study { false }
  end
end
