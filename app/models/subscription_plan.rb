# app/models/subscription_plan.rb
class SubscriptionPlan < ApplicationRecord
  has_many :subscriptions

  enum customer_type: { candidate: 0 }

  validates :name, presence: true, uniqueness: true
  validates :stripe_plan_id, presence: true, uniqueness: true
  validates :customer_type, presence: true
end
