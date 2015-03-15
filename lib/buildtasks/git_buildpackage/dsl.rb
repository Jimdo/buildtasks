require "buildtasks/mixins/dsl"

module BuildTasks
  module GitBuildpackage
    class DSL
      include BuildTasks::Mixins::DSL

      def initialize(&block)
        @name      = nil
        @version   = nil
        @source    = nil
        @patches   = []
        @changelog = nil

        instance_eval(&block) if block_given?
      end

      attr_reader :patches, :changelog

      def name(arg = nil)
        set_or_return(:name, arg, :kind_of => String)
      end

      def version(arg = nil)
        set_or_return(:version, arg, :kind_of => String)
      end

      def source(arg = nil)
        set_or_return(:source, arg, :kind_of => String)
      end

      def apply_patch(patch)
        @patches << patch
      end

      def update_changelog(text, options = {})
        @changelog = { :text => text }.merge(options)
      end
    end
  end
end
