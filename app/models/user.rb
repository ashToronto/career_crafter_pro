class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  enum role: { candidate: 0, admin: 1 }

  has_many :resumes, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  def active_subscription?
    subscriptions.any?(&:active_or_in_grace_period?)
  end

  def active_candidate_subscription?
    active_subscription? && subscriptions.any? { |s| s.subscription_plan.customer_type == 'candidate' }
  end
end
