require_relative '../lib/vending_machine'
require_relative '../lib/coin'

describe Vending_Machine do
  let(:vm) { Vending_Machine.new(display: 0) }
  let(:quarter) { Coin.new(weight: 5.67, diameter: 24.26)}
  let(:dime) { Coin.new(weight: 2.27, diameter: 17.90)}
  let(:nickel) { Coin.new(weight: 5.0, diameter: 21.21)}
  let(:penny) { Coin.new(weight: 2.5, diameter: 19.05)}

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

  it "should have an array for rejected_coins" do
    expect(vm.respond_to?(:rejected_coins)).to be(true)
  end

  context 'unaccepted coins should be put into rejected_coins' do
    it "should put a penny into rejected_coins" do
      vm.insert(penny)
      expect(vm.rejected_coins).to eq([penny])
    end
  end

  it "should have a products hash" do
    expect(vm.respond_to?(:products)).to be(true)
  end

  it "should have a select_product method" do
    expect(vm.respond_to?(:select_product)).to be(true)
  end

  it "should have a dispensed 'area' " do
    expect(vm.respond_to?(:dispensed)).to be(true)
  end

  it "select_product should take a choice and dispense that choice" do
    vm.insert(quarter)
    vm.insert(quarter)
    vm.select_product('chips')
    expect(vm.dispensed).to eq('chips')
  end

  context 'it only dispenses items if the proper amount has been inserted' do
    it "does not dispense chips if 0.40 has been inserted" do
      vm.insert(quarter)
      vm.insert(dime)
      vm.insert(nickel)
      expect(vm.display) == 0.40
      vm.select_product('chips')
      expect(vm.dispensed).to eq('')
    end

    it "dispenses cola after insertion of 3 quarters and 3 dimes" do
      vm.insert(quarter)
      vm.insert(quarter)
      vm.insert(quarter)
      vm.insert(dime)
      vm.insert(dime)
      vm.insert(dime)
      expect(vm.display).to eq(1.05)
      vm.select_product('cola')
      expect(vm.dispensed).to eq('cola')
    end
  end

  # context 'coin_tray to contain valid coins after insertion' do
  #   it "inserts a quarter into the coin tray" do
  #     vm.insert(quarter)
  #     expect(vm.coin_tray).to eq([quarter])
  #   end
  # end







end
