class Resume < ApplicationRecord
  belongs_to :user
  belongs_to :theme, optional: true
  has_many :experiences, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_one :cover_letter, dependent: :destroy
  has_one :social_link, dependent: :destroy

  before_validation :assign_default_theme, if: -> { theme_id.blank? }

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :job_title, presence: true

  private

  def assign_default_theme
    # Find the default theme by name or any other identifier
    default_theme = Theme.find_by(name: 'free_default')
    self.theme_id = default_theme.id if default_theme.present?
  end
end
