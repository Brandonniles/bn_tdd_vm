require_relative '../lib/coin'

describe Coin do
  let(:tc) { Coin.new(weight: 5.67, diameter: 24.26) }

  it "should have a weight attribute" do
    expect(tc.respond_to?(:weight)).to be(true)
  end

  it "should have a diameter attribute" do
    expect(tc.respond_to?(:diameter)).to be(true)
  end

end
