require 'simplecov'
SimpleCov.start 'rails' do
  add_group 'Workers', 'app/workers'
end

ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../spec/dummy/config/environment", __FILE__)

require 'rspec/rails'
require 'shoulda-matchers'
require 'paperclip/matchers'
require 'factory_girl_rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'sidekiq/testing'
require 'rack_session_access/capybara'
require 'brakeman'
require 'database_cleaner'

ActiveRecord::Migration.maintain_test_schema!

BCrypt::Engine::DEFAULT_COST = 1

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include Paperclip::Shoulda::Matchers
  config.before(:suite) {DatabaseCleaner.clean_with(:truncation)}
  config.before(:each) {DatabaseCleaner.strategy = :transaction}
  config.before(:each, js: true) {DatabaseCleaner.strategy = :truncation}
  config.before(:each) {DatabaseCleaner.start}
  config.after(:each) {DatabaseCleaner.clean}
  config.after(:suite) {Brakeman.run app_path: "#{Rails.root}", output_files: ['coverage/brakeman.html']}
  config.after(:suite) {FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])}
end
