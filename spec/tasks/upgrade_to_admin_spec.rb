require 'rails_helper'
require 'rake'

RSpec.describe 'admin:upgrade_to_admin', type: :task do
  before :all do
    Rake.application.load_rakefile
  end

  let(:task) { Rake::Task['admin:upgrade_to_admin'] }

  # Ensure the task environment is clean for each test
  before { task.reenable }

  context 'when no user is found' do
    it 'outputs a no user found message' do
      expect do
        task.invoke
      end.to output(/No user found with email:/).to_stdout
    end
  end

  context 'when the user is already an admin' do
    let!(:admin) { create(:user, :admin, email: 'admin@example.com') }

    it 'outputs a user is already an admin message' do
      ENV['ADMIN_EMAIL'] = 'admin@example.com'
      expect do
        task.execute
      end.to output(/User admin@example.com is already an admin./).to_stdout
    end
  end

  context 'when upgrading a regular user to admin' do
    let!(:user) { create(:user, email: 'free-tier@example.com') }

    it 'successfully upgrades the user to admin' do
      ENV['ADMIN_EMAIL'] = 'free-tier@example.com'
      expect do
        task.execute
      end.to output(/User free-tier@example.com has been successfully upgraded to admin./).to_stdout
      user.reload
      expect(user.role).to eql('admin')
    end
  end

  context 'when the upgrade fails' do
    let!(:user) { create(:user, email: 'failuser@example.com') }

    before do
      allow_any_instance_of(User).to receive(:save).and_return(false)
    end

    it 'outputs a failed to upgrade user message' do
      ENV['ADMIN_EMAIL'] = 'failuser@example.com'
      expect do
        task.execute
      end.to output(/Failed to upgrade user failuser@example.com to admin:/).to_stdout
    end
  end
end
