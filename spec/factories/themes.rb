FactoryBot.define do
  factory :theme do
    sequence(:name) { |n| "Theme #{n}" }
    active { true }
  end
end
