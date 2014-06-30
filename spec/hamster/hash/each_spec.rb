require "spec_helper"

require "hamster/hash"

describe Hamster::Hash do

  [:each, :foreach, :each_pair].each do |method|

    describe "##{method}" do

      before do
        @hash = Hamster.hash("A" => "aye", "B" => "bee", "C" => "see")
      end

      describe "with a block (internal iteration)" do

        it "returns self" do
          @hash.send(method) {}.should be(@hash)
        end

        it "yields all key/value pairs" do
          actual_pairs = {}
          @hash.send(method) { |key, value| actual_pairs[key] = value }
          actual_pairs.should == { "A" => "aye", "B" => "bee", "C" => "see" }
        end

      end

      describe "with no block" do

        it "returns an Enumerator" do
          @result = @hash.send(method)
          @result.class.should be(Enumerator)
          @result.to_a.should == @hash.to_a
        end

      end

    end

  end

end
