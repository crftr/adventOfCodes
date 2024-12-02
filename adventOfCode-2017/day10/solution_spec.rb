require 'rspec'
require './solution'

describe KnotHash do

  describe 'Part 1, example implementation' do

    before(:each) do
      @kh = KnotHash.new(5, [3, 4, 1, 5])
    end

    it 'will have the assumed default values' do
      expect(@kh.current_pos).to eql(0)
      expect(@kh.skip_size).to   eql(0)
      expect(@kh.list).to        eql([0, 1, 2, 3, 4])
      expect(@kh.lengths).to     eql([3, 4, 1, 5])
    end

    it 'will iterate, 1 time' do
      @kh.iterate
      expect(@kh.current_pos).to eql(3)
      expect(@kh.skip_size).to   eql(1)
      expect(@kh.list).to        eql([2, 1, 0, 3, 4])
      expect(@kh.lengths).to     eql([4, 1, 5])
    end

    it 'will iterate, 2 times' do
      @kh.iterate
      @kh.iterate
      expect(@kh.current_pos).to eql(3)
      expect(@kh.skip_size).to   eql(2)
      expect(@kh.list).to        eql([4, 3, 0, 1, 2])
      expect(@kh.lengths).to     eql([1, 5])
    end

    it 'will iterate, 3 times' do
      @kh.iterate
      @kh.iterate
      @kh.iterate
      expect(@kh.current_pos).to eql(1)
      expect(@kh.skip_size).to   eql(3)
      expect(@kh.list).to        eql([4, 3, 0, 1, 2])
      expect(@kh.lengths).to     eql([5])
    end

    it 'will iterate, 4 times' do
      @kh.iterate
      @kh.iterate
      @kh.iterate
      @kh.iterate
      expect(@kh.current_pos).to eql(4)
      expect(@kh.skip_size).to   eql(4)
      expect(@kh.list).to        eql([3, 4, 2, 1, 0])
      expect(@kh.lengths).to     eql([])
    end
  end

  describe 'Part 2, example implementation' do
    it 'will create a dense_hash' do
      k = KnotHash.new(16)
      k.list = [65, 27, 9, 1, 4, 3, 40, 50, 91, 7, 6, 0, 2, 5, 68, 22]

      expect(k.dense_hash(16)).to eql([64])
    end

    it 'will generate a hexadecimal from an array of elements' do
      k = KnotHash.new(16)

      expect(k.hexadecimal([64, 7, 255])).to eql('4007ff')
    end

    examples = [
      ['',         'a2582a3a0e66e6e86e3812dcb672a272'],
      ['AoC 2017', '33efeb34ea91902bb2f59c9920caa6cd'],
      ['1,2,3',    '3efbe78a8d82f29979031a4aa0b16a9d'],
      ['1,2,4',    '63960835bcdc130f0b66d7ff4f6a5a8e']
    ]

    examples.each do |eg|
      it 'hashes with all functionality' do
        @part2_k = KnotHash.new(256, eg[0])
        @part2_k.iterate_rounds(64)

        dense_hash = @part2_k.dense_hash

        expect(@part2_k.hexadecimal(dense_hash)).to eql(eg[1])
      end
    end
  end
end

describe KnotInputConverter do

  examples = [
    ['1,2,3', [49, 44, 50, 44, 51, 17, 31, 73, 47, 23]],
    ['',      [17, 31, 73, 47, 23]],
  ]

  examples.each do |eg|
    it { expect(KnotInputConverter.call(eg[0])).to eql(eg[1]) }
  end
end
