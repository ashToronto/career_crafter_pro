class Resume < ApplicationRecord
  belongs_to :user
  has_many :experiences, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_one :social_link, dependent: :destroy

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :job_title, presence: true
end
