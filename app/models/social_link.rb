class SocialLink < ApplicationRecord
  belongs_to :resume

  validate :at_least_one_social_link

  VALID_URL_REGEX = %r{\A(http|https)://[a-zA-Z0-9\-.]+\.[a-zA-Z]{2,}\z}
  validates :personal_website_url, format: { with: VALID_URL_REGEX }, allow_blank: true

  validates :linkedin_url, format: { with: %r{\A(http|https)://(www\.)?linkedin\.com/.*\z} }, allow_blank: true
  validates :github_url, format: { with: %r{\A(http|https)://(www\.)?github\.com/.*\z} }, allow_blank: true
  validates :twitter_url, format: { with: %r{\A(http|https)://(www\.)?twitter\.com/.*\z} }, allow_blank: true
  validates :youtube_url, format: { with: %r{\A(http|https)://(www\.)?youtube\.com/.*\z} }, allow_blank: true
  validates :facebook_url, format: { with: %r{\A(http|https)://(www\.)?facebook\.com/.*\z} }, allow_blank: true
  validates :instagram_url, format: { with: %r{\A(http|https)://(www\.)?instagram\.com/.*\z} }, allow_blank: true

  def at_least_one_social_link
    if [linkedin_url, github_url, twitter_url, youtube_url, facebook_url, instagram_url,
        personal_website_url].all?(&:blank?)
      errors.add(:base, 'At least one social link must be provided.')
    end
  end
end
