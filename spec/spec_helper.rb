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
end

Spork.each_run do
  # This code will be run each time you run your specs.

end

# --- Instructions ---
# Sort the contents of this file into a Spork.prefork and a Spork.each_run
# block.
#
# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
#
# The Spork.each_run block is run each time you run your specs.  In case you
# need to load files that tend to change during development, require them here.
# With Rails, your application modules are loaded automatically, so sometimes
# this block can remain empty.
#
# Note: You can modify files loaded *from* the Spork.each_run block without
# restarting the spork server.  However, this file itself will not be reloaded,
# so if you change any of the code inside the each_run block, you still need to
# restart the server.  In general, if you have non-trivial code in this file,
# it's advisable to move it into a separate file so you can easily edit it
# without restarting spork.  (For example, with RSpec, you could move
# non-trivial code into a file spec/support/my_helper.rb, making sure that the
# spec/support/* files are require'd from inside the each_run block.)
#
# Any code that is left outside the two blocks will be run during preforking
# *and* during each_run -- that's probably not what you want.
#
# These instructions should self-destruct in 10 seconds.  If they don't, feel
# free to delete them.


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
