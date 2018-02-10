class Coin
  attr_accessor :weight, :diameter

  def initialize(weight:, diameter:)
    @weight = weight.round(2)
    @diameter = diameter.round(2)
  end
end
