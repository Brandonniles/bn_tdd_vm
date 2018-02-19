require_relative './coin'

module Change_coins
  attr_accessor :quarter, :dime, :nickel, :change

  def initialize(quarter:, dime:, nickel:, change:)
    @quarter = Coin.new(weight: 5.67, diameter: 24.26)
    @dime = Coin.new(weight: 2.27, diameter: 17.90)
    @nickel = Coin.new(weight: 5.0, diameter: 21.21)
    @change = [@quarter, @dime, @nickel]
  end

end
