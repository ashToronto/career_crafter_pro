# spec/rails_helper.rb

require 'spec_helper'
require 'support/simplecov'
require 'faker'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'shoulda/matchers'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_paths = ["#{::Rails.root}/spec/fixtures"]
  config.use_transactional_fixtures = true
  config.include Devise::Test::ControllerHelpers, type: :controller
  # config.use_active_record = false # Uncomment this line if you're not using ActiveRecord

  # factory bot
  config.include FactoryBot::Syntax::Methods

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  # config.filter_gems_from_backtrace("gem name") # You can add specific gem names to filter from backtrace
end
