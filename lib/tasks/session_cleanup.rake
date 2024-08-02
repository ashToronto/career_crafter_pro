# rake session:cleanup
namespace :session do
  desc 'Clean up old sessions'
  task cleanup: :environment do
    ActiveRecord::SessionStore::Session.where('updated_at < ?', 2.weeks.ago).delete_all
    puts 'Old sessions cleaned up'
  end
end
