class SocialLink < ApplicationRecord
  belongs_to :resume

  VALID_URL_REGEX = %r{\A(http|https)://[a-zA-Z0-9\-.]+\.[a-zA-Z]{2,}\z}
  validates :personal_website_url, format: { with: VALID_URL_REGEX }, allow_blank: true

  validates :linkedin_url, format: { with: %r{\A(http|https)://(www\.)?linkedin\.com/.*\z} }, allow_blank: true
  validates :github_url, format: { with: %r{\A(http|https)://(www\.)?github\.com/.*\z} }, allow_blank: true
  validates :twitter_url, format: { with: %r{\A(http|https)://(www\.)?twitter\.com/.*\z} }, allow_blank: true
  validates :youtube_url, format: { with: %r{\A(http|https)://(www\.)?youtube\.com/.*\z} }, allow_blank: true
  validates :facebook_url, format: { with: %r{\A(http|https)://(www\.)?facebook\.com/.*\z} }, allow_blank: true
  validates :instagram_url, format: { with: %r{\A(http|https)://(www\.)?instagram\.com/.*\z} }, allow_blank: true
end
