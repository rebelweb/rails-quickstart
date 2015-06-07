puts "Generating with Rails Quickstart Template"

#Add this folder to path temporarily
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

#Replace Default Gemfile
remove_file 'Gemfile'
copy_file 'quickstart-Gemfile', 'Gemfile'

#Load Settings File
copy_file 'settings.yml', 'config/settings.yml'
copy_file 'load_settings.rb', 'config/initializers/load_settings.rb'

#Load .gitignore file
remove_file '.gitignore'
copy_file 'quickstart-gitignore', '.gitignore'

#Load sidekiq settings
copy_file 'sidekiq.yml', 'config/sidekiq.yml'
copy_file 'set_active_job_queue_adapter.rb', 'config/initializers/set_active_job_queue_adapter.rb'

#Add a basic 503 Unavailable Page
copy_file '503.html', 'public/503.html'

#Setup RSpec
copy_file 'quickstart-rails_helper.rb', 'spec/rails_helper.rb'
copy_file 'quickstart-spec_helper.rb', 'spec/spec_helper.rb'
create_file 'spec/controllers/.keep'
create_file 'spec/factories/.keep'
create_file 'spec/features/.keep'
create_file 'spec/helpers/.keep'
create_file 'spec/jobs/.keep'
create_file 'spec/models/.keep'
create_file 'spec/mailers/.keep'
create_file 'spec/routing/.keep'
create_file 'spec/support/.keep'

#Bullet Setup
insert_into_file 'config/environments/development.rb', before: "Rails.application.configure do\n" do <<-RUBY
  require 'bullet'

  RUBY
end

insert_into_file 'config/environments/development.rb', before: "# config.action_view.raise_on_missing_translations = true\n" do <<-RUBY

  #Configure Bullet
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
  end
  RUBY
end

after_bundle do
  run 'git init'
  run 'git add --all'
  run 'git commit -m "Initial Commit"'
  run 'atom .'
end
