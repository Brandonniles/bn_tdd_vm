require_relative './coin'
class Vending_Machine

  attr_accessor :display, :inserted_coins, :coin_return, :products, :dispensed, :quarter, :nickel, :dime, :change_coins, :product_stock

  def initialize(display:)
    @inserted_coins = []
    @display = 'INSERT COIN'
    @coin_return = []
    @products = {"cola" => 1.00, "chips" => 0.50, "candy" => 0.65}
    @product_stock = {"cola" => 5, "chips" => 5, "candy" => 5}
    @dispensed = ''
    @quarter = Coin.new(weight: 5.67, diameter: 24.26)
    @dime = Coin.new(weight: 2.27, diameter: 17.90)
    @nickel = Coin.new(weight: 5.0, diameter: 21.21)
    @change_coins = {@quarter => "0.25", @dime => "0.10", @nickel => "0.05"}

  end

  def make_change(num)
    @change_coins.each do |k, v|
      (num.to_f / v.to_f).to_i.times { @coin_return << k; num = "%.2f" % (num.to_f - v.to_f) }
    end
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
      make_change(@display.to_f - @products[choice].to_f)
      @product_stock[choice] -= 1
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
