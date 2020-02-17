class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    return 0.hash if self.empty?
    total = self.first
    self[1..-1].each do |ele|
      total = (total ^ ele).hash
    end
    total
  end
end

class String
  def hash 
    alpha = ("a".."z").to_a
    total = alpha.index(self[0]).hash 
    self[1..-1].each_char do |char|
      total = (total.hash ^ alpha.index(char)).hash 
    end

    total
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys.length.hash
  end
end
