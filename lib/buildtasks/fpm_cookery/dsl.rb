require "buildtasks/mixins/dsl"

module BuildTasks
  module FPMCookery
    class DSL
      include BuildTasks::Mixins::DSL

      def initialize(&block)
        @recipe              = "recipe.rb"
        @fpm_cookery_version = "~> 0.25.0"
        @fpm_version         = "~> 1.3.3"

        instance_eval(&block) if block_given?
      end

      def recipe(arg = nil)
        set_or_return(:recipe, arg, :kind_of => String)
      end

      def fpm_cookery_version(arg = nil)
        set_or_return(:fpm_cookery_version, arg, :kind_of => String)
      end

      def fpm_version(arg = nil)
        set_or_return(:fpm_version, arg, :kind_of => String)
      end
    end
  end
end
