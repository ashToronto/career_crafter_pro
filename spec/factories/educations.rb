FactoryBot.define do
  factory :education do
    resume { nil }
    institution_name { "MyString" }
    location { "MyString" }
    field_of_study { "MyString" }
    degree { 1 }
    start_date { "2024-03-22" }
    end_date { "2024-03-22" }
    currently_study { false }
  end
end
