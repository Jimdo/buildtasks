require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

desc "Run RuboCop style and lint checks"
RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ["-D"]
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = "--color --format documentation"
end

task :test => [:rubocop, :spec]
task :default => :test
