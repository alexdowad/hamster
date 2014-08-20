require "spec_helper"
require "hamster/list"

describe "Hamster.list#span" do
  it "is lazy" do
    -> { Hamster.stream { |item| fail }.span { true } }.should_not raise_error
  end

  describe <<-DESC do
given a predicate (in the form of a block), splits the list into two lists
  (returned as an array) such that elements in the first list (the prefix) are
  taken from the head of the list while the predicate is satisfied, and elements
  in the second list (the remainder) are the remaining elements from the list
  once the predicate is not satisfied. For example:
DESC

    [
      [[], [], []],
      [[1], [1], []],
      [[1, 2], [1, 2], []],
      [[1, 2, 3], [1, 2], [3]],
      [[1, 2, 3, 4], [1, 2], [3, 4]],
      [[2, 3, 4], [2], [3, 4]],
      [[3, 4], [], [3, 4]],
      [[4], [], [4]],
    ].each do |values, expected_prefix, expected_remainder|
      context "given the list #{values.inspect}" do
        let(:list) { Hamster.list(*values) }

        context "and a predicate that returns true for values <= 2" do
          let(:result) { list.span { |item| item <= 2 }}
          let(:prefix) { result.first }
          let(:remainder) { result.last }

          it "preserves the original" do
            result
            list.should eql(Hamster.list(*values))
          end

          it "returns the prefix as #{expected_prefix.inspect}" do
            prefix.should eql(Hamster.list(*expected_prefix))
          end

          it "returns the remainder as #{expected_remainder.inspect}" do
            remainder.should eql(Hamster.list(*expected_remainder))
          end
        end

        context "without a predicate" do
          it "returns a frozen array" do
            list.span.class.should be(Array)
            list.span.should be_frozen
          end

          it "returns self as the prefix" do
            list.span.first.should equal(list)
          end

          it "returns an empty list as the remainder" do
            list.span.last.should be_empty
          end
        end
      end
    end
  end
end