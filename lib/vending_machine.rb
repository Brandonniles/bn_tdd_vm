class Vending_Machine
  attr_accessor :display

  def initialize(display:)
    @display = 'INSERT COIN'
  end

  def insert(coin)
    @display = display.to_f + 0.25 if coin.weight == 5.67 && coin.diameter == 24.26 
  end

end
