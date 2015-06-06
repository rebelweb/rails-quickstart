puts "Generating with Rails Quickstart Template"

def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

remove_file 'Gemfile'
copy_file 'quickstart-Gemfile', 'Gemfile'
