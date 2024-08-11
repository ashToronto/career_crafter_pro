class Resume < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :user, counter_cache: :resumes_count
  belongs_to :theme, optional: true
  has_many :experiences, -> { order(end_date: :desc) }, dependent: :destroy
  has_many :educations, -> { order(end_date: :desc) }, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_one :cover_letter, dependent: :destroy
  has_one :social_link, dependent: :destroy

  before_validation :assign_default_theme, if: -> { theme_id.blank? }

  validates :user_id, presence: true
  validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }
  validates :country, presence: true
  validates :state, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :job_title, presence: true

  validate :resume_limit, on: :create

  def slug_candidates
    [
      %i[first_name last_name job_title]
    ]
  end

  private

  def assign_default_theme
    # Find the default theme by name or any other identifier
    default_theme = Theme.find_by(name: 'free_default')
    self.theme_id = default_theme.id if default_theme.present?
  end

  def resume_limit
    return unless user.present? && user.resumes.count >= 3

    errors.add(:base, 'You can only create a maximum of 3 resumes.')
  end
end
