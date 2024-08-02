# spec/tasks/session_cleanup_spec.rb

require 'rails_helper'
require 'rake'

RSpec.describe 'session:cleanup', type: :task do
  before :all do
    Rake.application.load_rakefile
    ActiveRecord::SessionStore::Session.delete_all
  end

  let(:task) { Rake::Task['session:cleanup'] }

  it 'deletes sessions that have not been updated in the last two weeks' do
    # Create sessions to test the cleanup
    old_session = ActiveRecord::SessionStore::Session.create!(
      session_id: 'old_session',
      data: {},
      updated_at: 3.weeks.ago
    )
    new_session = ActiveRecord::SessionStore::Session.create!(
      session_id: 'new_session',
      data: {},
      updated_at: 1.week.ago
    )

    expect do
      task.execute
    end.to change { ActiveRecord::SessionStore::Session.count }.from(2).to(1)
  end
end
