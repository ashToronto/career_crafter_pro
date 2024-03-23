require 'rails_helper'

RSpec.describe Education, type: :model do
  # Ensure the education factory is valid
  it 'has a valid factory' do
    expect(build(:education)).to be_valid
  end

  # Test suite for Education validations
  describe 'validations' do
    it { should validate_presence_of(:institution_name) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:field_of_study) }
    it { should validate_presence_of(:degree) }
    it { should validate_presence_of(:start_date) }

    it 'is not valid without a valid degree' do
      expect(build(:education, degree: nil)).not_to be_valid
    end

    it 'is valid with valid degree enums' do
      expect(build(:education, degree: :high_school)).to be_valid
      expect(build(:education, degree: :bachelor)).to be_valid
      expect(build(:education, degree: :masters)).to be_valid
      expect(build(:education, degree: :certificate)).to be_valid
    end

    context 'when currently_study is false' do
      it 'is not valid if end_date is before start_date' do
        education = build(:education, start_date: Date.today, end_date: Date.yesterday, currently_study: false)
        expect(education).not_to be_valid
        expect(education.errors[:end_date]).to include('must be after the start date')
      end
    end

    context 'when currently_study is true' do
      it 'is valid if end_date is nil' do
        education = build(:education, start_date: Date.today, end_date: nil, currently_study: true)
        expect(education).to be_valid
      end
    end
  end

  # Test suite for Education associations
  describe 'associations' do
    it { should belong_to(:resume) }
  end
end
