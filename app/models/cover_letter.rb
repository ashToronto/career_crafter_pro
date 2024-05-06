class CoverLetter < ApplicationRecord
  has_rich_text :content
  belongs_to :resume

  validates :content, presence: true
end
