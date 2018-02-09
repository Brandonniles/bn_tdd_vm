class Coin
  attr_accessor :name, :weight, :diameter

  def initialize(name:, weight:, diameter:)
    @name = name
    @weight = weight
    @diameter = diameter
  end
end
