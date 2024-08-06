# spec/requests/user_sessions_spec.rb

require 'rails_helper'

RSpec.describe 'UserSessions', type: :request do
  let(:user) { create(:user, confirmed_at: Time.now) }

  describe 'User login, signup, and logout' do
    context 'when a user signs up' do
      it 'creates a new user and session' do
        expect do
          post user_registration_path,
               params: { user: { email: 'newuser@example.com', password: 'password',
                                 password_confirmation: 'password' } }
        end.to change(User, :count).by(1) # Ensure a new user is created
                                   .and change {
                                          ActiveRecord::SessionStore::Session.count
                                        }.by(1) # Ensure a new session is created
      end
    end

    context 'when a user logs in' do
      before do
        # Register a new user and confirm their email
        post user_registration_path,
             params: { user: { email: 'newuser@example.com', password: 'password',
                               password_confirmation: 'password' } }
        user = User.find_by(email: 'newuser@example.com')
        user.update!(confirmed_at: Time.now) # Simulate email confirmation
        sign_out :user
      end

      it 'updates the session data without creating a duplicate session' do
        old_session_id = ActiveRecord::SessionStore::Session.last&.session_id

        expect do
          post user_session_path,
               params: { user: { email: 'newuser@example.com', password: 'password' } }
        end.not_to(change { ActiveRecord::SessionStore::Session.count }) # Ensure no new session is created

        new_session_id = ActiveRecord::SessionStore::Session.last&.session_id
        session_data = ActiveRecord::SessionStore::Session.last&.data

        expect(new_session_id).not_to eq(old_session_id) # Ensure the session ID is updated
        expect(session_data).to include('warden.user.user.key') # Ensure the session data includes the user key
      end
    end

    context 'when a user logs out' do
      before do
        sign_in user
      end

      it 'updates the session data or creates a new session without including the user key' do
        old_session_id = ActiveRecord::SessionStore::Session.last&.session_id

        expect do
          delete destroy_user_session_path
        end.to(change { ActiveRecord::SessionStore::Session.count }) # Allow for the session count to change

        new_session_id = ActiveRecord::SessionStore::Session.last&.session_id
        session_data = ActiveRecord::SessionStore::Session.last&.data

        expect(new_session_id).not_to eq(old_session_id) # Ensure the session ID is updated
        expect(session_data).not_to include('warden.user.user.key') # Ensure the session data no longer includes the user key
      end
    end
  end
end
