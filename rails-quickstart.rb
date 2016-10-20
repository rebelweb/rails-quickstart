puts "Setting Up Stuff Quickly"
#Add this folder to path temporarily
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

after_bundle do
  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end
