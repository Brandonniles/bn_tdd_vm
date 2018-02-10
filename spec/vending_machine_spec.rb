require_relative '../lib/vending_machine'
require_relative '../lib/coin'

describe Vending_Machine do
  let(:vm) { Vending_Machine.new(display: 0) }
  let(:quarter) { Coin.new(weight: 5.67, diameter: 24.26)}
  let(:dime) { Coin.new(weight: 2.67, diameter: 17.90)}
  let(:nickel) { Coin.new(weight: 5.0, diameter: 21.21)}

  it "has a display attribute" do
    expect(vm.respond_to?(:display)).to be(true)
  end

  it "should have a default display set to 'INSERT COIN'" do
    expect(vm.display).to eq('INSERT COIN')
  end

  it "has an insert method" do
    expect(vm.respond_to?(:insert)).to be(true)
  end

  it 'display should update to 0.25 after insertion of a quarter' do
    expect(vm.display).to eq('INSERT COIN')
    vm.insert(quarter)
    expect(vm.display).to eq(0.25)
  end

  it "display should update to .50 after insertion of a quarter twice" do
    expect(vm.display).to eq('INSERT COIN')
    vm.insert(quarter)
    expect(vm.display).to eq(0.25)
    vm.insert(quarter)
    expect(vm.display).to eq(0.50)
  end

  it "display should update to .35 after insertion of a quarter and a dime" do
    expect(vm.display).to eq('INSERT COIN')
    vm.insert(quarter)
    expect(vm.display).to eq(0.25)
    vm.insert(dime)
    expect(vm.display).to eq(0.35)
  end

  it "display should update to 0.05 after insertion of a nickel" do
    vm.insert(nickel)
    expect(vm.display).to eq(0.05)
  end

  it "display should update to .10 after insertion of 2 nickels" do
    expect(vm.display).to eq('INSERT COIN')
    vm.insert(nickel)
    expect(vm.display).to eq(0.05)
    vm.insert(nickel)
    expect(vm.display).to eq(0.10)
  end

end
