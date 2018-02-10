class Vending_Machine
  attr_accessor :display, :rejected_coins, :products

  def initialize(display:)
    @display = 'INSERT COIN'
    @rejected_coins = []
    @products = {"Cola" => 1.00, "Chips" => 0.50, "Candy" => 0.65}
  end

  def insert(coin)
    if coin.weight == 5.67 && coin.diameter == 24.26
      @display = display.to_f + 0.25
    elsif coin.weight == 2.27 && coin.diameter == 17.90
      @display = display.to_f + 0.10
    elsif coin.weight == 5.0 && coin.diameter == 21.21
      @display = display.to_f + 0.05
    else
      @rejected_coins << coin
    end
  end

end
