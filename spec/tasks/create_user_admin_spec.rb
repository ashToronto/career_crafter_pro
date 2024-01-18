require 'rails_helper'
require 'rake'

RSpec.describe 'admin:create_admin', type: :task do
  before :all do
    Rake.application.load_rakefile
  end

  let(:task) { Rake::Task['admin:create_admin'] }

  # Reset the task (important for tasks that might run multiple times in tests)
  before { task.reenable }

  context 'when creating a new admin user' do
    it 'creates an admin user if one does not exist' do
      expect {
        task.execute
      }.to change(User, :count).by(1)

      user = User.find_by(email: 'admin@example.com')
      expect(user).to be_present
      expect(user).to be_admin
    end
  end

  context 'when updating an existing admin user' do
    let!(:existing_admin) { create(:user, :admin, email: 'admin@example.com') }

    it 'does not create a new user' do
      expect {
        task.execute
      }.not_to change(User, :count)

    end
  end

  context 'when the task fails' do
    # Simulate a failure, such as trying to create a user with an invalid email
    before { allow(User).to receive(:find_or_create_by).and_raise(StandardError) }

    it 'does not create a new user' do
      expect {
        expect { task.execute }.to raise_error(StandardError)
      }.not_to change(User, :count)
    end
  end
end
