require "buildtasks/git_buildpackage/tasks"

describe BuildTasks::GitBuildpackage::Tasks do
  it "creates Rake tasks from DSL attributes" do
    Rake::Task.clear
    expect(Rake::Task.tasks).to be_empty

    attributes = double(
      :name      => "some-name",
      :version   => "some-version",
      :source    => "some-source",
      :patches   => [],
      :changelog => nil
    )

    BuildTasks::GitBuildpackage::Tasks.new(attributes)
    expect(Rake::Task.task_defined? "build").to be_truthy
    expect(Rake::Task.task_defined? "publish").to be_truthy
  end
end
