#
# Ruby lib used by all recipes based on fpm-cookery
#

require "buildtasks/fpm_cookery/dsl"
require "buildtasks/fpm_cookery/tasks"

module BuildTasks
  module FPMCookery
    def self.define_tasks(&block)
      attributes = BuildTasks::FPMCookery::DSL.new(&block)
      BuildTasks::FPMCookery::Tasks.new(attributes)
    end
  end
end
