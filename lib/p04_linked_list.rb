class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = self.next
    self.next.prev = self.prev
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.prev = @tail
    @tail.next = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.prev
  end

  def last
    @tail.next
  end

  def empty?
    @head.prev == @tail
  end

  def get(key)
    current = @tail.next
    until current == @head
      return current.val if current.key == key
      current = current.next
    end
    nil

  end

  def include?(key)
    current = @tail.next
    until current == @head
      return true if current.key == key
      current = current.next
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.prev = @tail
    new_link.next = @tail.next
    @tail.next.prev = new_link
    @tail.next = new_link
  end

  def update(key, val)
    current = @tail.next
    until current == @head
      current.val = val if current.key == key
      current = current.next
    end
  end

  def remove(key)
    current = @tail.next
    until current == @head
      if current.key == key
        current.prev.next = current.next
        current.next.prev = current.prev
      end
      current = current.next
    end

  end

  def each
    current = @head.prev
    until current == @tail
      yield(current)
      current = current.prev
    end
  end


  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
