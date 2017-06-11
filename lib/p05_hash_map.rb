require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    @count += 1 unless include?(key)
    bucket(key).append(key, val)
    resize! if @count == num_buckets

  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 if include?(key)
    bucket(key).remove(key)
  end

  def each
    @store.each do |linkedlist|
      linkedlist.each do |link|
        yield(link.key, link.val)
      end
    end
  end


  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    all_lists = {}
    each { |k, v| all_lists[k] = v }
    initialize(num_buckets * 2)
    all_lists.each { |k, v| set(k, v)  }
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
