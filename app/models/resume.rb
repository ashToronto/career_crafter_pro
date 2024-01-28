class Resume < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :job_title, presence: true
end
