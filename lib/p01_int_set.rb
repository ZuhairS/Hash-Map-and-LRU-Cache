class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    @store[num] = true unless include?(num)
  end

  def remove(num)
    @store[num] = false if include?(num)
  end

  def include?(num)
    validate!(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    (0..@max).to_a.include?(num)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    inspect
    unless include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  def show
    @store
  end
  
  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    allnum = @store.flatten
    # test_case = ResizingIntSet.new(num_buckets * 2)
    initialize(num_buckets * 2)
    until allnum.empty?
      self.insert(allnum.pop)
    end
  end


  def inspect
    resize! if @count >= num_buckets
  end
end
