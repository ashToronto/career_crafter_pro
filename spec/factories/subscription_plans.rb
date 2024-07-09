# spec/factories/subscription_plans.rb
FactoryBot.define do
  factory :subscription_plan do
    name { 'Basic Plan' }
    stripe_plan_id { "price_#{SecureRandom.hex(6)}" }
    customer_type { :candidate }
  end
end
