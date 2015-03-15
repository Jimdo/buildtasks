module BuildTasks
  module Mixins
    module Tasks
      def sudo(cmd)
        return cmd if Process.uid == 0
        "sudo " + cmd
      end
    end
  end
end
