require "buildtasks/fpm_cookery/dsl"
require "buildtasks/fpm_cookery/tasks"

module BuildTasks
  module FPMCookery
    def self.define(&block)
      attributes = BuildTasks::FPMCookery::DSL.new(&block)
      BuildTasks::FPMCookery::Tasks.new(attributes)
    end
  end
end
