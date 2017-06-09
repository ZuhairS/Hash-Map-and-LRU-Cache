class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashstr = ""
    each do |ele|
      hashstr += ele.object_id.to_s(2)
    end
    hashstr.to_i.hash
  end
end

class String
  def hash
    chararr = chars
    hashstr = ""
    chararr.each do |lttr|
      hashstr += lttr.ord.to_s(2)
    end
    hashstr.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashsum = 0
    each do |k, v|
      hashsum += k.to_s.hash + v.to_s.hash
    end
    hashsum.hash
  end
end
