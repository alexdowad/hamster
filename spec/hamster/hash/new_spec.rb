require "spec_helper"
require "hamster/hash"

describe Hamster::Hash do
  describe "new" do
    describe "from a subclass" do
      before do
        @subclass = Class.new(Hamster::Hash)
        @instance = @subclass.new("some" => "values")
      end

      it "should return an instance of the subclass" do
        @instance.class.should be @subclass
      end

      it "should return a frozen instance" do
        @instance.frozen?.should be true
      end
    end
  end
end