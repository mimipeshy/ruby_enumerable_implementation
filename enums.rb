# rubocop:disable Metrics/ModuleLength
module Enumerable
  # rubocop:enable Metrics/ModuleLength
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def my_each
    return to_enum(:my_each) unless block_given?

    size.times do |i|
      yield to_a[i]
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    size.times do |i|
      yield to_a[i], i
    end
    self
  end

  def my_all?(arg = nil)
    if block_given? && !arg.nil?
      return false unless my_all?(arg) && my_all?
    end
    if block_given?
      my_each { |i| return false unless yield(i) }
    elsif arg.nil?
      my_each { |i| return false unless i }
    elsif arg.class == Class
      my_each { |i| return false unless i.class <= arg }
    elsif arg.class == Regexp
      my_each { |i| return false unless i =~ arg }
    else
      my_each { |i| return false unless i == arg && i.class <= arg.class }
    end

    true
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_array = []
    my_each do |i|
      new_array.push(i) if yield(i)
    end
    new_array
  end

  def my_any?(arg = nil)
    if block_given? && !arg.nil?
      return true if my_any?(arg) && my_any?
    end

    if block_given?
      my_each { |i| return true if yield(i) }
    elsif arg.nil?
      my_each { |i| return true if i }
    elsif arg.class == Class
      my_each { |i| return true if i.class <= arg }
    elsif arg.class == Regexp
      my_each { |i| return true if i =~ arg }
    else
      my_each { |i| return true if i == arg && i.class <= arg.class }
    end
    false
  end

  def my_none?(arg = nil)
    if block_given? && !arg.nil?
      return true if my_none?(arg) && my_none?
    end
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif arg.nil?
      my_each { |i| return false if i }
    elsif arg.class == Class
      my_each do |i|
        return false if i.class <= arg
      end
    elsif arg.class == Regexp
      my_each { |i| return false if i =~ arg }
    else
      my_each { |i| return false if i == arg && i.class <= arg.class }
    end
    true
  end

  def my_count(*arg)
    return 'error arguments' if arg.length > 1

    cont1 = 0
    array = to_a
    if block_given?
      array.length.times do |a|
        array[a]
        cont1 += 1 if yield (array[a])
        next
      end
      return cont1
    else
      return array.length if arg.empty?

      array.length.times do |a|
        cont1 += 1 if array[a].eql?(arg[0])
        next
      end
    end
    cont1
  end

  def my_map(&arg)
    return to_enum(:my_map) unless block_given?

    modified_array = []
    my_each { |i| modified_array << arg.call(i) }

    modified_array
  end

  def my_inject(*arg)
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    raise LocalJumpError unless block_given? || !arg.empty?

    sym = arg.pop unless block_given?
    my_array = arg + to_a
    memo = my_array.shift
    if block_given?
      my_array.my_each { |el| memo = yield(memo, el) }
    else
      my_array.my_each { |el| memo = memo.send(sym, el) }
    end
    memo
  end

  def multiply_els
    my_inject { |i, a| i * a }
  end
end
