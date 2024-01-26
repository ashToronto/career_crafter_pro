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
  end
end
