require "spec_helper"
require "hamster/list"

describe Hamster::List do
  describe "#rotate" do
    before do
      @list = Hamster.list(1,2,3,4,5)
    end

    context "when passed no argument" do
      it "returns a new list with the first element moved to the end" do
        @list.rotate.should eql(Hamster.list(2,3,4,5,1))
      end
    end

    context "with an integral argument n" do
      it "returns a new list with the first (n % size) elements moved to the end" do
        @list.rotate(2).should eql(Hamster.list(3,4,5,1,2))
        @list.rotate(3).should eql(Hamster.list(4,5,1,2,3))
        @list.rotate(4).should eql(Hamster.list(5,1,2,3,4))
        @list.rotate(5).should eql(Hamster.list(1,2,3,4,5))
        @list.rotate(-1).should eql(Hamster.list(5,1,2,3,4))
      end
    end

    context "with a non-numeric argument" do
      it "raises a TypeError" do
        -> { @list.rotate('hello') }.should raise_error(TypeError)
      end
    end

    context "with an argument of zero" do
      it "it returns self" do
        @list.rotate(0).should be(@list)
      end
    end
  end
end