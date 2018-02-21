require_relative '../lib/vending_machine'
require_relative '../lib/coin'

describe Vending_Machine do
  let(:vm) { Vending_Machine.new(display: 0) }
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
    vm.insert(vm.quarter)
    expect(vm.display).to eq("0.25")
  end

  it "display should update to .50 after insertion of a quarter twice" do
    expect(vm.display).to eq('INSERT COIN')
    vm.insert(vm.quarter)
    expect(vm.display).to eq("0.25")
    vm.insert(vm.quarter)
    expect(vm.display).to eq("0.50")
  end

  it "display should update to .35 after insertion of a quarter and a dime" do
    expect(vm.display).to eq('INSERT COIN')
    vm.insert(vm.quarter)
    expect(vm.display).to eq("0.25")
    vm.insert(vm.dime)
    expect(vm.display).to eq("0.35")
  end

  it "display should update to 0.05 after insertion of a nickel" do
    vm.insert(vm.nickel)
    expect(vm.display).to eq("0.05")
  end

  it "display should update to .10 after insertion of 2 nickels" do
    expect(vm.display).to eq('INSERT COIN')
    vm.insert(vm.nickel)
    expect(vm.display).to eq("0.05")
    vm.insert(vm.nickel)
    expect(vm.display).to eq("0.10")
  end

  it "should have an array for coin_return" do
    expect(vm.respond_to?(:coin_return)).to be(true)
  end

  context 'unaccepted coins should be put into coin_return' do
    it "should put a penny into coin_return" do
      vm.insert(penny)
      expect(vm.coin_return).to eq([penny])
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
    vm.insert(vm.quarter)
    vm.insert(vm.quarter)
    vm.select_product('chips')
    expect(vm.dispensed).to eq('chips')
  end

  context 'it only dispenses items if the proper amount has been inserted' do
    it "does not dispense chips if 0.40 has been inserted" do
      vm.insert(vm.quarter)
      vm.insert(vm.dime)
      vm.insert(vm.nickel)
      expect(vm.display).to eq("0.40")
      vm.select_product('chips')
      expect(vm.dispensed).to eq('')
    end

    it "dispenses cola after insertion of 3 quarters and 3 dimes" do
      vm.insert(vm.quarter)
      vm.insert(vm.quarter)
      vm.insert(vm.quarter)
      vm.insert(vm.dime)
      vm.insert(vm.dime)
      vm.insert(vm.dime)
      expect(vm.display).to eq("1.05")
      vm.select_product('cola')
      expect(vm.dispensed).to eq('cola')
    end
  end

  it "says 'INSERT COIN' after displaying 'THANK YOU'" do
    vm.insert(vm.quarter)
    vm.insert(vm.quarter)
    vm.select_product('chips')
    expect(vm.dispensed).to eq('chips')
    expect(vm.display).to eq('INSERT COIN')
  end

  context "displays 'PRICE NUM' when not enough money inserted" do
    it "displays 'PRICE 1.00' for 3 dimes inserted and cola selection" do
      vm.insert(vm.dime)
      vm.insert(vm.dime)
      vm.insert(vm.dime)
      vm.select_product('cola')
      expect(vm.display).to eq('PRICE 1.00')
    end

    it "displays 'PRICE 0.65' for 2 quarters inserted and candy selection" do
      vm.insert(vm.quarter)
      vm.insert(vm.quarter)
      vm.select_product('candy')
      expect(vm.display).to eq('PRICE 0.65')
    end
  end

  it "inserted_coins has 2 quarters after insertion of 2 quarters" do
    vm.insert(vm.quarter)
    vm.insert(vm.quarter)
    expect(vm.inserted_coins).to eq([vm.quarter, vm.quarter])
  end

  it "inserts 1 nickel and 2 dimes then returns said coins when return_coins is called" do
    vm.insert(vm.nickel)
    vm.insert(vm.dime)
    vm.insert(vm.dime)
    vm.return_coins
    expect(vm.coin_return).to eq([vm.dime, vm.dime, vm.nickel])
  end

  it "empties @inserted_coins of 2 dimes when return_coins is called" do
    vm.insert(vm.dime)
    vm.insert(vm.dime)
    vm.return_coins
    expect(vm.inserted_coins).to eq([])
  end

  it "displays 'INSERT COIN' after return_coins is called" do
    vm.insert(vm.dime)
    vm.return_coins
    expect(vm.display).to eq('INSERT COIN')
  end

  it "returns a nickel when change amount is 0.05" do
    vm.make_change(0.05)
    expect(vm.coin_return).to eq([vm.nickel])
  end

  it "returns a quarter when change amount is 0.25" do
    vm.make_change(0.25)
    expect(vm.coin_return).to eq([vm.quarter])
  end

  it "returns a quarter and nickel when change amount 0.30" do
    vm.make_change(0.30)
    expect(vm.coin_return).to eq([vm.quarter, vm.nickel])
  end

  it "returns two quarters when change amount 0.50" do
    vm.make_change(0.50)
    expect(vm.coin_return).to eq([vm.quarter, vm.quarter])
  end

  it "returns two quarters and two dimes when change amount 0.70" do
    vm.make_change(0.70)
    expect(vm.coin_return).to eq([vm.quarter, vm.quarter, vm.dime, vm.dime])
  end

  it "returns 3 quarters and a nickel when change amount 0.80" do
    vm.make_change(0.80)
    expect(vm.coin_return).to eq([vm.quarter, vm.quarter, vm.quarter, vm.nickel])
  end

  it "dispenses 'candy' and also returns a quarter and a dime after inserting a dollar and selecting candy" do
    vm.insert(vm.quarter)
    vm.insert(vm.quarter)
    vm.insert(vm.quarter)
    vm.insert(vm.quarter)
    vm.select_product('candy')
    expect(vm.dispensed).to eq('candy')
    expect(vm.coin_return).to eq([vm.quarter, vm.dime])
  end

  it "decreases chips stock by 1 when buying chips" do
    vm.insert(vm.quarter)
    vm.insert(vm.quarter)
    expect(vm.product_stock['chips']).to eq(5)
    vm.select_product('chips')
    expect(vm.product_stock['chips']).to eq(4)
  end

  it "displays 'SOLD OUT' then original display status if trying to select an item that is out" do
    vm.insert(vm.quarter)
    vm.insert(vm.quarter)
    vm.insert(vm.quarter)
    vm.check_inventory('candy')
    expect(vm.display).to eq('0.75')
  end

  it "has a default exact_change_mode of 'false'" do
    expect(vm.exact_change_mode).to eq(false)
  end

  it "displays 'EXACT CHANGE ONLY' if exact_change_mode is switched to true" do
    expect(vm.display).to eq('INSERT COIN')
    vm.switch_mode
    expect(vm.exact_change_mode).to eq(true)
    expect(vm.display).to eq('EXACT CHANGE ONLY')
  end


end
