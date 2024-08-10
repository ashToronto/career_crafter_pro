# spec/models/resume_spec.rb

require 'rails_helper'

RSpec.describe Resume, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
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
end
