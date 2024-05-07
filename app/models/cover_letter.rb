class CoverLetter < ApplicationRecord
  has_rich_text :content
  belongs_to :resume

  validates :content, presence: true
  validate :no_attachments_in_content

  private

  def no_attachments_in_content
    return unless content.body.attachments.any?

    errors.add(:content, 'cannot contain attachments.')
  end
end
