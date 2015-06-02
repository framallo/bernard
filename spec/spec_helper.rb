require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'pocket_money'
  require 'rspec/rails'
  require 'rspec/autorun'
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

    config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    end

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

    config.before(:each) do
      page.driver.allow_url("www.google.com") rescue nil
      page.driver.allow_url("http://ajax.googleapis.com/ajax/static/modules/gviz/1.0/core/tooltip.css") rescue nil
    end

    config.include FactoryGirl::Syntax::Methods

    config.include(Capybara::DSL, :type => :feature)

    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = true
    end

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

  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end
