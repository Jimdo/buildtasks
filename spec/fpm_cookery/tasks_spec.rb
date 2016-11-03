require "buildtasks/fpm_cookery/tasks"
require "tmpdir"

describe BuildTasks::FPMCookery::Tasks do
  before(:each) do
    Rake::Task.clear
  end

  it "creates Rake tasks from DSL attributes" do
    expect(Rake::Task.tasks).to be_empty

    attributes = double(
      :recipe              => "some-recipe",
      :fpm_cookery_version => nil,
      :fpm_version         => nil
    )

    allow(File).to receive(:exist?).with("some-recipe").and_return(true)
    allow(File).to receive(:exist?).with("Gemfile").and_return(false)

    BuildTasks::FPMCookery::Tasks.new(attributes)
    expect(Rake::Task.task_defined?("build")).to be_truthy
    expect(Rake::Task.task_defined?("publish")).to be_truthy
  end

  it "creates Gemfile to define gem dependencies" do
    attributes = double(
      :recipe              => "some-recipe",
      :fpm_cookery_version => "some-version",
      :fpm_version         => "another-version"
    )

    allow(File).to receive(:exist?).with("some-recipe").and_return(true)
    allow(File).to receive(:exist?).with("Gemfile").and_return(false)

    BuildTasks::FPMCookery::Tasks.new(attributes)

    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        Rake::Task["Gemfile"].invoke
        content = File.read("Gemfile")
        expect(content).to include "gem 'fpm-cookery', 'some-version'"
        expect(content).to include "gem 'fpm', 'another-version'"
      end
    end
  end
end
