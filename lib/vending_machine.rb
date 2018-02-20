require_relative './coin'
class Vending_Machine

  attr_accessor :display, :inserted_coins, :coin_return, :products, :dispensed, :quarter, :nickel, :dime

  def initialize(display:)
    @inserted_coins = []
    @display = 'INSERT COIN'
    @coin_return = []
    @products = {"cola" => 1.00, "chips" => 0.50, "candy" => 0.65}
    @dispensed = ''
    @quarter = Coin.new(weight: 5.67, diameter: 24.26)
    @dime = Coin.new(weight: 2.27, diameter: 17.90)
    @nickel = Coin.new(weight: 5.0, diameter: 21.21)
  end

  def make_change(num)
    @coin_return << @nickel if num.to_f == 0.05
    @coin_return << @quarter if num.to_f == 0.25
  end

  def insert(coin)
    if coin.weight == 5.67 && coin.diameter == 24.26
      @display = "%.2f" % (display.to_f + 0.25); @inserted_coins << coin
    elsif coin.weight == 2.27 && coin.diameter == 17.90
      @display = "%.2f" % (display.to_f + 0.10); @inserted_coins << coin
    elsif coin.weight == 5.0 && coin.diameter == 21.21
      @display = "%.2f" % (display.to_f + 0.05); @inserted_coins << coin
    else
      @coin_return << coin
    end
  end

  def select_product(choice)
    if @display.to_f >= @products[choice].to_f
      @dispensed = choice; @display = 'THANK YOU'
      sleep(0); @display = 'INSERT COIN'
    else
      @display = "PRICE #{"%.2f" % (@products[choice])}"
    end
  end

  def return_coins
    @inserted_coins.length.times { |i| @coin_return << @inserted_coins.pop() }
    @display = 'INSERT COIN'
  end

end
