# app/models/education.rb
class Education < ApplicationRecord
  belongs_to :resume

  enum degree: { high_school: 0, bachelor: 1, masters: 2, certificate: 3 }

  validates :institution_name, :location, :field_of_study, :degree, :start_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank? || currently_study?

    errors.add(:end_date, 'must be after the start date') if end_date < start_date
  end
end
