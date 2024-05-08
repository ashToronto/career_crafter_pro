class Theme < ApplicationRecord
  has_many :resumes, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :active, inclusion: { in: [true, false] }
end
