require "buildtasks/fpm_cookery/dsl"

describe BuildTasks::FPMCookery::DSL do
  subject { BuildTasks::FPMCookery::DSL.new }

  it "initializes attributes" do
    expect(subject.recipe).to eq "recipe.rb"
    expect(subject.fpm_cookery_version).to eq "~> 0.27.0"
    expect(subject.fpm_version).to eq "~> 1.3.3"
  end

  it "handles recipe attribute" do
    subject.recipe "some-recipe"
    expect(subject.recipe).to eq "some-recipe"
  end

  it "handles fpm_cookery_version attribute" do
    subject.fpm_cookery_version "some-version"
    expect(subject.fpm_cookery_version).to eq "some-version"
  end

  it "handles fpm_version attribute" do
    subject.fpm_version "some-version"
    expect(subject.fpm_version).to eq "some-version"
  end

  it "handles passing attributes via block" do
    dsl = BuildTasks::FPMCookery::DSL.new do
      recipe              "some-recipe"
      fpm_cookery_version "some-version"
      fpm_version         "another-version"
    end
    expect(dsl.recipe).to eq "some-recipe"
    expect(dsl.fpm_cookery_version).to eq "some-version"
    expect(dsl.fpm_version).to eq "another-version"
  end
end
