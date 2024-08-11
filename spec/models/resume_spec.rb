# spec/models/resume_spec.rb

require 'rails_helper'

RSpec.describe Resume, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:experiences).order(end_date: :desc).dependent(:destroy) }
    it { should have_many(:educations).order(end_date: :desc).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }

    it 'is valid with valid attributes' do
      user = create(:user)
      resume = build(:resume, user: user)
      expect(resume).to be_valid
    end

    it 'is invalid without a user' do
      resume = build(:resume, user: nil)
      expect(resume).not_to be_valid
    end

    context 'when the user has reached the resume limit' do
      let(:user) { create(:user) }

      it 'does not allow the user to create more than 3 resumes' do
        create_list(:resume, 3, user: user)

        new_resume = build(:resume, user: user)
        expect(new_resume).not_to be_valid
        expect(new_resume.errors[:base]).to include('You can only create a maximum of 3 resumes.')
      end

      it 'allows the user to create up to 3 resumes' do
        create_list(:resume, 2, user: user)

        third_resume = build(:resume, user: user)
        expect(third_resume).to be_valid
      end
    end
  end

  describe 'ordering of experiences and educations' do
    let(:resume) { create(:resume) }

    let!(:experience1) { create(:experience, resume: resume, start_date: 3.years.ago, end_date: 2.years.ago) }
    let!(:experience2) { create(:experience, resume: resume, start_date: 2.years.ago, end_date: 1.year.ago) }
    # Currently working status set to true
    let!(:experience3) do
      create(:experience, resume: resume, start_date: 1.year.ago, end_date: nil, current_work: true)
    end
    let!(:education1) { create(:education, resume: resume, start_date: 3.years.ago, end_date: 3.years.ago) }
    let!(:education2) { create(:education, resume: resume, start_date: 3.years.ago, end_date: 2.years.ago) }
    # Currently studying status set to true
    let!(:education3) do
      create(:education, resume: resume, start_date: 1.year.ago, end_date: nil, currently_study: true)
    end
    it 'orders experiences by end_date in descending order' do
      expect(resume.experiences).to eq([experience3, experience2, experience1])
    end

    it 'orders educations by end_date in descending order' do
      expect(resume.educations).to eq([education3, education2, education1])
    end
  end
end
