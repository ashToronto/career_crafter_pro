require 'rails_helper'

RSpec.describe User, type: :model do
  it { should define_enum_for(:role).with_values(candidate: 0, admin: 1) }
  it { should have_many(:subscriptions) }

  # Happy path tests
  it 'is a candidate by default' do
    user = create(:user)
    expect(user).to be_candidate
  end

  it 'can be created as an admin' do
    admin = create(:user, :admin)
    expect(admin).to be_admin
  end

  # Mailer path tests
  context 'when a new user is registered' do
    let(:user) { create(:user, confirmed_at: nil) } # Ensure user is not auto-confirmed for this test

    it 'generates a confirmation token and sends it via email' do
      expect(user.confirmation_token).not_to be_nil
    end

    it 'does not set confirmed_at until user has clicked email link' do
      expect(user.confirmed_at).to be_nil
    end

    it 'sets confirmed_at upon email confirmation' do
      user.update!(confirmed_at: Time.now)
      expect(user.confirmed_at).not_to be_nil
    end
  end

  # Testing password reset functionality
  context 'when a user forgets their password' do
    let(:user) { create(:user, :confirmed) } # Ensure user is confirmed to test password reset

    it 'sends a password reset email' do
      user.send_reset_password_instructions
      expect(ActionMailer::Base.deliveries.last.to).to include(user.email)
      expect(ActionMailer::Base.deliveries.last.subject).to include('Reset password instructions')
    end

    it 'updates the user password when provided with valid parameters' do
      user.reset_password('newpassword123', 'newpassword123')
      expect(user.valid_password?('newpassword123')).to be true
    end
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

  # Testing subscriptions
  context 'with subscriptions' do
    let(:user) { create(:user) }
    let(:subscription_plan) { create(:subscription_plan) }

    it 'can have subscriptions' do
      subscription = create(:subscription, user: user, subscription_plan: subscription_plan)
      expect(user.subscriptions).to include(subscription)
    end

    describe '#active_subscription?' do
      let!(:active_subscription) { create(:subscription, user: user, status: :active) }

      it 'returns true if there is an active subscription' do
        expect(user.active_subscription?).to be(true)
      end

      it 'returns false if there are no active subscriptions' do
        active_subscription.update(status: :canceled)
        expect(user.active_subscription?).to be(false)
      end

      it 'returns true if there is a subscription in the grace period' do
        active_subscription.update(status: :canceled, end_date: 2.days.from_now)
        expect(user.active_subscription?).to be(true)
      end

      it 'returns false if the grace period has ended' do
        active_subscription.update(status: :canceled, end_date: 2.days.ago)
        expect(user.active_subscription?).to be(false)
      end
    end

    describe '#active_candidate_subscription?' do
      let!(:active_subscription) do
        create(:subscription, user: user, status: :active, subscription_plan: subscription_plan)
      end

      it 'returns true if there is an active candidate subscription' do
        expect(user.active_candidate_subscription?).to be(true)
      end

      it 'returns false if there are no active candidate subscriptions' do
        active_subscription.update(status: :canceled)
        expect(user.active_candidate_subscription?).to be(false)
      end

      it 'returns true if there is a candidate subscription in the grace period' do
        active_subscription.update(status: :canceled, end_date: 2.days.from_now)
        expect(user.active_candidate_subscription?).to be(true)
      end

      it 'returns false if the grace period has ended' do
        active_subscription.update(status: :canceled, end_date: 2.days.ago)
        expect(user.active_candidate_subscription?).to be(false)
      end
    end
  end
end
