# spec/factories/subscriptions.rb
FactoryBot.define do
  factory :subscription do
    user
    subscription_plan
    stripe_subscription_id { "sub_#{SecureRandom.hex(8)}" }
    status { :active }
  end
end
