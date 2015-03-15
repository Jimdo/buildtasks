require "buildtasks/mixins/dsl"

describe BuildTasks::Mixins::DSL do
  describe "#set_or_return" do
    it "returns current value" do
      c = Class.new do
        include BuildTasks::Mixins::DSL
        def initialize
          @some_attribute = :some_value
        end
      end.new
      expect(c.set_or_return(:some_attribute, nil)).to eq :some_value
    end

    it "sets new value" do
      c = Class.new do
        include BuildTasks::Mixins::DSL
        attr_reader :some_attribute
      end.new
      c.set_or_return(:some_attribute, :some_value)
      expect(c.some_attribute).to eq :some_value
    end

    context "validation" do
      let(:c) do
        Class.new do
          include BuildTasks::Mixins::DSL
        end.new
      end

      it "checks if value is of a specfic kind" do
        expect do
          c.set_or_return(:some_attribute, "some-value", :kind_of => String)
          c.set_or_return(:some_attribute, :some_value, :kind_of => Symbol)
          c.set_or_return(:some_attribute, 1234, :kind_of => Fixnum)
          c.set_or_return(:some_attribute, true, :kind_of => TrueClass)
          c.set_or_return(:some_attribute, false, :kind_of => FalseClass)
          c.set_or_return(:some_attribute, 1, :kind_of => [TrueClass, Integer])
        end.not_to raise_error
      end

      it "raises an exception if value is not of kind" do
        expect do
          c.set_or_return(:some_attribute, "some-value", :kind_of => Integer)
        end.to raise_error(ArgumentError, "some_attribute must be of kind [Integer]")

        expect do
          c.set_or_return(:some_attribute, 1234, :kind_of => [String, TrueClass])
        end.to raise_error(ArgumentError, "some_attribute must be of kind [String, TrueClass]")
      end
    end
  end
end
