require "spec_helper"

describe Boolio do
  let(:true_boolio)  { Boolio.new val: true }
  let(:false_boolio) { Boolio.new val: false }

  it "has a version number" do
    expect(Boolio::VERSION).not_to be nil
  end

  it "has an endpoint URL constant" do
    expect(Boolio::URL).to eq "https://api.booleans.io/"
  end

  it "throws exception if invalid argument type is provided" do
    expect{ Boolio.new val: 3 }.to raise_error(ArgumentError)
  end

  it "takes value argument on initialize" do
    expect(true_boolio.val).to eq true
    expect(false_boolio.val).to eq false
  end

  it "assigns a random boolean if no value argument is passed" do
    expect([true, false]).to include(Boolio.new().val)
  end

  it "assigns retreived ID from created boolean" do
    expect(true_boolio.id).to be_instance_of String
  end
end
