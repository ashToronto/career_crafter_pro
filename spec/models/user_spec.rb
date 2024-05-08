require 'rails_helper'

RSpec.describe User, type: :model do
  # Happy path tests

  it 'is a candidate by default' do
    user = create(:user)
    expect(user).to be_candidate
  end

  it 'can be created as an admin' do
    admin = create(:user, :admin)
    expect(admin).to be_admin
  end

  # Sad path tests

  context 'with invalid attributes' do
    it 'does not create a user with invalid email' do
      user = build(:user, email: 'invalid_email')
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include('is invalid')
    end

    it 'does not create a user with no email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include("can't be blank")
    end

    it 'does not create a user with a short password' do
      user = build(:user, password: 'short', password_confirmation: 'short')
      expect(user).not_to be_valid
      expect(user.errors.messages[:password]).to include('is too short (minimum is 6 characters)')
    end

    it 'does not create a user if the password confirmation does not match' do
      user = build(:user, password: 'password123', password_confirmation: 'different')
      expect(user).not_to be_valid
      expect(user.errors.messages[:password_confirmation]).to include("doesn't match Password")
    end
  end

  context 'Resumes' do
    it { should have_many(:resumes) }
  end
end
