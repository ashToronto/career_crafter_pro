# app/models/experience.rb
class Experience < ApplicationRecord
  belongs_to :resume

  before_save :clear_end_date_if_current_work

  validates :company_name, :start_date, :job_title, :city, :province, presence: true
  validate :end_date_after_start_date

  private

  def clear_end_date_if_current_work
    self.end_date = nil if current_work?
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank? || current_work?

    errors.add(:end_date, 'must be after the start date') if end_date < start_date
  end
end
