class CoverLetter < ApplicationRecord
  belongs_to :resume

  validates :content, presence: true
end
