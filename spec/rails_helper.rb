require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'spec_helper'
  require 'pocket_money'
  require 'rspec/rails'
  require 'factory_girl_rails'  
  require 'shoulda/matchers'
  require 'capybara/rspec'
  require 'capybara/rails'
  require 'database_cleaner'
  require 'email_spec'
  require 'simplecov'
  require 'devise'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  SimpleCov.start 'rails' do
    simplecov_formatters = [ SimpleCov::Formatter::HTMLFormatter ]
    SimpleCov.formatters = simplecov_formatters
  end

  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    config.use_transactional_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.before(:each, :js => true) do
      DatabaseCleaner.strategy = :truncation
    end

    config.include FactoryGirl::Syntax::Methods

    config.include(Capybara::DSL, :type => :feature)

    config.around(:each) do |example|
      DatabaseCleaner.cleaning do
        example.run
      end
    end

    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)

    Capybara.javascript_driver = :webkit

    config.filter_run focus: true
    config.run_all_when_everything_filtered = true

    config.include Devise::TestHelpers, :type => :controller
    config.infer_spec_type_from_file_location!

  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end

