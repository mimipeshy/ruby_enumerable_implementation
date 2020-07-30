require_relative '../enums.rb'

# rubocop:disable Layout/LineLength
describe Enumerable do
  let(:my_array) { [1, 2, 3, 4, 5] }
  let(:my_hash) { { x: 1, y: 2, z: 3 } }
  let(:my_range) { (1..10) }
  let(:my_string) { %w[ant bear cat] }
  let(:my_proc) { proc | value | value * 2 }

  describe '#my_each' do
    context 'when the method is called using a block ' do
      it 'runs block for each element in the variable, passing it as an argument and returning an array' do
        expect(my_array.my_each { |i| my_array[i] }).to eq(my_array.each { |i| my_array[i] })
      end
      it 'runs block for each element in the variable, passing it as an argument and returning an hash' do
        expect(my_hash.my_each { |a| p a }).to eq(my_hash.each { |u| p u })
      end
      it 'runs block for each element in the range, passing it as an argument and returning an range' do
        expect(my_range.my_each { |e| p e }).to eq(my_range.each { |a| p a })
      end
      it 'returns an enumerable if the block is not given. ' do
        expect(my_array.my_each).to be_an Enumerator
      end
    end
  end

  describe '#my_each_with_index' do
    context 'when the method is called using a block ' do
      it 'runs a block a code for an array and returns an element and index ' do
        expect(my_array.my_each_with_index { |k, v| k + v }).to eq(my_array.each_with_index { |k, v| k + v })
      end
      it 'runs a block a code for an hash and returns an element and index' do
        expect(my_hash.my_each_with_index { |k, v| k.to_s + v.to_s }).to eq(my_hash.each_with_index { |k, v| k.to_s + v.to_s })
      end
      it 'runs a block a code for an range and returns an element and index' do
        expect(my_range.my_each_with_index { |k, v| k + v }).to eq(my_range.each_with_index { |k, v| k + v })
      end
      it 'returns an enumerable if the block is not given. ' do
        expect(my_array.my_each_with_index).to be_an Enumerator
      end
    end
  end

  describe '#my_select' do
    context 'when the method is called using a block ' do
      it 'returns an array with the elements which pass the condition ' do
        expect(my_array.my_select { |i| i > 3 }).to eq(my_array.select { |i| i > 3 })
      end
      it 'returns an array with the elements which pass the condition' do
        expect(my_range.my_select { |i| i > 3 }).to eq(my_range.select { |i| i > 3 })
      end
      it 'returns an enumerable if the block is not given. ' do
        expect(my_array.my_select).to be_an Enumerator
      end
    end
  end

  describe '#my_all?' do
    context 'when method is passed using an argument ' do
      it 'returns a true value if all elements pass the condition (strings) ' do
        expect(my_string.my_all?(/t/)).to eq(false)
      end
      it 'returns a true value if all elements pass the condition (numbers)' do
        expect(my_array.all?(Numeric)).to eq(true)
      end
    end
    context 'when a block is given ' do
      it 'the method returns a true value if all elements pass the condition (numbers)' do
        expect(my_array.all? { |i| i >= 2 }).to eq(false)
      end
      it 'the method returns a true value if all elements pass the condition (string)' do
        expect(my_array.all?(/t/) { |value| value >= 2 }).to eq(false)
      end
    end
  end

  describe '#my_any?' do
    context 'when method is passed using an argument ' do
      it 'returns true if any value passes the condition otherwise returns false (strings) ' do
        expect(my_string.my_any?(/t/)).to eq(true)
      end
      it 'returns a true value if all elements pass the condition (numbers)' do
        expect(my_array.any?(Numeric)).to eq(true)
      end
    end
    context 'when a block is given ' do
      it 'when no block is given ruby adds implicit block' do
        expect(my_array.any?).to eq(true)
      end
      it 'the method returns true when any value passes the condition ortherwise returns false (numbers)' do
        expect(my_array.any? { |value| value == 10 }).to eq(false)
      end
      it 'the method returns a true value if all elements pass the condition (string)' do
        expect(my_array.any?(/t/) { |value| value >= 2 }).to eq(false)
      end
    end
  end

  describe '#my_none?' do
    context 'when method is passed using an argument ' do
      it 'returns true if any value passes the condition otherwise returns false (strings) ' do
        expect(my_string.my_none?(/t/)).to eq(false)
      end
      it 'returns a true value if all elements pass the condition (numbers)' do
        expect(my_array.my_none?(Numeric)).to eq(false)
      end
    end
    context 'when a block is given ' do
      it 'when no block is given ruby adds implicit block' do
        expect(my_array.my_none?).to eq(false)
      end
      it 'the method returns true when any value passes the condition ortherwise returns false (numbers)' do
        expect(my_array.my_none? { |value| value == 10 }).to eq(true)
      end
      it 'the method returns a true value if all elements pass the condition (string)' do
        expect(my_array.my_none?(/t/) { |value| value >= 2 }).to eq(false)
      end
    end
  end

  describe '#my_count' do
    context 'when a block is given ' do
      it 'my_count with any argument' do
        expect(my_array.my_count).to eq(my_array.count)
      end
    end
    it 'my_count with a number argument' do
      expect(my_array.my_count(2)). to eq(my_array.count(2))
    end
    it 'when no block is given ruby adds implicit block' do
      expect(my_array.my_count { |x| (x % 2).zero? }).to eq(my_array.count { |x| (x % 2).zero? })
    end
    it 'when no block is given ruby adds implicit block' do
      expect(my_array.my_count { |x| (x % 2).zero? }).to eq(my_array.count { |x| (x % 2).zero? })
    end
    it 'when no block is given ruby adds implicit block' do
      expect(my_array.my_count { |x| (x % 2).zero? }).to eq(my_array.count { |x| (x % 2).zero? })
    end
    it 'the method returns true when any value passes the condition ortherwise returns false (numbers)' do
      expect(my_array.my_count { |value| value }).to eq(my_array.count { |value| value })
    end
  end
  describe '#my_inject' do
    context 'when a block is given ' do
      it 'my_inject with a block multiply' do
        expect(my_array.my_inject { |value| value * 2 }).to eq(my_array.my_inject { |value| value * 2 })
      end
      it 'my_inject with a block addition' do
        expect(my_range.my_inject { |value| value + 2 }).to eq(my_range.inject { |value| value + 2 })
      end
      it 'my_inject with two arguments' do
        expect(my_range.my_inject(1, :*)).to eq(my_range.inject(1, :*))
      end
      it 'my_inject with an argument and a block to multiply' do
        expect(my_range.my_inject(1) { |product, n| product * n }).to eq(my_range.inject(1) { |product, n| product * n })
      end
      it 'my_inject with checks for the longest word in an array' do
        expect(my_string.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eq(my_string.inject { |memo, word| memo.length > word.length ? memo : word })
      end
    end
  end
end
# rubocop:enable Layout/LineLength
