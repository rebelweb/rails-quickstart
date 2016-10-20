puts "Setting Up Stuff Quickly"

#Add this folder to path temporarily
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

# Setup Environment Variables
gem 'dotenv-rails', group: [:development, :test]

append_to_file ".gitignore", ".env"

create_file '.env-example', <<-ENV
DB_HOST='127.0.0.1'
DB_USER=''
DB_PASS=''
ENV

# RSpec Setup
if yes?('Do you want to use RSpec?')
  gem_group :development, :test do
    gem 'rspec-rails'
    gem 'rails-controller-testing'
    gem 'factory_girl_rails'
    gem 'capybara'
    gem 'poltergeist'
    gem 'simplecov'
  end

  generate('rspec:install')
end

after_bundle do
  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end
