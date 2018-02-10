class Vending_Machine
  attr_accessor :display

  def initialize(display:)
    @display = 'INSERT COIN'
  end

  def insert(coin)
    @display = display.to_f + 0.25 if coin.weight == 5.67 && coin.diameter == 24.26
    @display = display.to_f + 0.10 if coin.weight == 2.67 && coin.diameter == 17.9
    @display = display.to_f + 0.05 if coin.weight == 5.0 && coin.diameter == 21.21
  end

end
