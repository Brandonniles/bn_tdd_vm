require_relative '../lib/coin'

describe Coin do

  it "should have a name attribute" do
    expect(Coin.new(name: 'dime').respond_to?(:name)).to be(true)
  end
end
