require "buildtasks/mixins/tasks"

describe BuildTasks::Mixins::Tasks do
  let(:c) do
    Class.new do
      include BuildTasks::Mixins::Tasks
    end.new
  end

  describe "#sudo" do
    it "runs command via sudo if not root" do
      allow(Process).to receive(:uid).and_return 1000
      expect(c.sudo("shutdown -fr")).to eq "sudo shutdown -fr"
    end

    it "runs command as-is if already root" do
      allow(Process).to receive(:uid).and_return 0
      expect(c.sudo("shutdown -fr")).to eq "shutdown -fr"
    end
  end
end
