# app/models/subscription.rb
class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscription_plan

  enum status: { active: 0, canceled: 1 }

  validates :stripe_subscription_id, presence: true, uniqueness: true
  validates :status, presence: true
  validates :subscription_plan, presence: true

  def active_or_in_grace_period?
    active? || (canceled? && end_date.present? && end_date > Time.current)
  end
end
