require_relative '../lib/vending_machine'

describe Vending_Machine do
  let(:vm) { Vending_Machine.new(display: 0) }

  it "has a display attribute" do
    expect(vm.respond_to?(:display)).to be(true)
  end

  it "has an insert method" do
    expect(vm.respond_to?(:insert)).to be(true)
  end
end
