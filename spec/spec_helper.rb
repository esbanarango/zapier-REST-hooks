$LOAD_PATH.unshift(File.dirname(__FILE__))
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rspec/rails'
require 'shoulda-matchers'
require 'database_cleaner'
require 'factory_girl_rails'
require 'codeclimate-test-reporter'
require 'fakeweb'
CodeClimate::TestReporter.start
FakeWeb.allow_net_connect = true

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

DatabaseCleaner.strategy = :truncation

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false

  config.after(:each, type: :request) do
    DatabaseCleaner.clean # Truncate the database
  end
end
