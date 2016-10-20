puts "Generating with Rails Quickstart Template"

#Add this folder to path temporarily
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end
