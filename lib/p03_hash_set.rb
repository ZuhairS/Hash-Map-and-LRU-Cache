require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    inspect
    unless include?(key)
      self[key.hash] << key
      @count += 1
    end
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key.hash].delete(key)
      @count -= 1
    end
  end

  def show
    @store
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
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
