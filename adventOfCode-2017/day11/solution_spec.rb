require 'rspec'
require './solution.rb'

describe HexEd do

  distance_examples = [
    [['ne', 'ne', 'ne'],             3],
    [['ne', 'ne', 'sw', 'sw'],       0],
    [['ne', 'ne', 's', 's'],         2],
    [['se', 'sw', 'se', 'sw', 'sw'], 3]
  ]

  distance_examples.each do |eg|
    it { expect(HexEd.new(eg[0]).distance).to eql(eg[1]) }
  end
end
