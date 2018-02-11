class Vending_Machine
  attr_accessor :display, :rejected_coins, :products, :dispensed

  def initialize(display:)
    @display = 'INSERT COIN'
    @rejected_coins = []
    @products = {"cola" => 1.00, "chips" => 0.50, "candy" => 0.65}
    @dispensed = ''
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

  def select_product(choice)
    @dispensed = choice if @display.to_f >= @products[choice].to_f
  end

end
