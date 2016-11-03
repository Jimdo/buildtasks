module BuildTasks
  module Mixins
    module Tasks
      def sudo(cmd)
        return cmd if Process.uid.zero?
        "sudo " + cmd
      end
    end
  end
end
