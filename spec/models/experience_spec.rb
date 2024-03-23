require 'rails_helper'

RSpec.describe Experience, type: :model do
  # Ensure the experience factory is valid
  it 'has a valid factory' do
    expect(build(:experience)).to be_valid
  end

  # Test suite for Experience validations
  describe 'validations' do
    it { should validate_presence_of(:company_name) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:job_title) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:province) }

    let(:resume) { create(:resume) }

    context 'when current_work is false' do
      it 'is not valid if end_date is before start_date' do
        experience = build(:experience, start_date: Date.today, end_date: Date.yesterday, current_work: false)
        expect(experience).not_to be_valid
        expect(experience.errors[:end_date]).to include('must be after the start date')
      end
    end

    context 'when current_work is true' do
      it 'clears end_date before saving' do
        experience = build(:experience, start_date: Date.today, end_date: Date.tomorrow, current_work: true,
                                        resume: resume)
        experience.save
        expect(experience.end_date).to be_nil
      end
    end
  end

  # Test suite for Experience associations
  describe 'associations' do
    it { should belong_to(:resume) }
  end
end
