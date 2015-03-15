#
# Ruby lib used by all recipes based on git-buildpackage
#

require "buildtasks/git_buildpackage/dsl"
require "buildtasks/git_buildpackage/tasks"

module BuildTasks
  module GitBuildpackage
    def self.define_tasks(&block)
      attributes = BuildTasks::GitBuildpackage::DSL.new(&block)
      BuildTasks::GitBuildpackage::Tasks.new(attributes)
    end
  end
end
