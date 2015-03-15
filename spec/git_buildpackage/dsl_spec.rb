require "buildtasks/git_buildpackage/dsl"

describe BuildTasks::GitBuildpackage::DSL do
  subject { BuildTasks::GitBuildpackage::DSL.new }

  it "initializes attributes" do
    expect(subject.name).to be_nil
    expect(subject.version).to be_nil
    expect(subject.source).to be_nil
    expect(subject.patches).to eq []
    expect(subject.changelog).to eq nil
  end

  it "handles name attribute" do
    subject.name "some-name"
    expect(subject.name).to eq "some-name"
  end

  it "handles version attribute" do
    subject.version "some-version"
    expect(subject.version).to eq "some-version"
  end

  it "handles source attribute" do
    subject.source "some-source"
    expect(subject.source).to eq "some-source"
  end

  it "handles apply_patch attribute" do
    subject.apply_patch "some-patch"
    subject.apply_patch "another-patch"
    expect(subject.patches).to eq %w(some-patch another-patch)
  end

  it "handles update_changelog attribute" do
    subject.update_changelog "some-text", :version => "some-version"
    expect(subject.changelog[:text]).to eq "some-text"
    expect(subject.changelog[:version]).to eq "some-version"
  end

  it "handles passing attributes via block" do
    dsl = BuildTasks::GitBuildpackage::DSL.new do
      name             "some-name"
      version          "some-version"
      source           "some-source"
      apply_patch      "some-patch"
      apply_patch      "another-patch"
      update_changelog "some-text", :version => "some-version"
    end
    expect(dsl.name).to eq "some-name"
    expect(dsl.version).to eq "some-version"
    expect(dsl.source).to eq "some-source"
    expect(dsl.patches).to eq %w(some-patch another-patch)
    expect(dsl.changelog[:text]).to eq "some-text"
    expect(dsl.changelog[:version]).to eq "some-version"
  end
end
