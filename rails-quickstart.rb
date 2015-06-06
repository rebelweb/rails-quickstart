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
