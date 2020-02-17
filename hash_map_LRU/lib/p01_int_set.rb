require "byebug"
class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise 'Out of bounds' if num > @store.length || num < 0
    @store[num] = true
    true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return true if @store[num]
    false
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    modulo = num % num_buckets
    @store[modulo] << num
  end

  def remove(num)
    modulo = num % num_buckets 
    @store[modulo].delete(num)
  end

  def include?(num)
    modulo = num % num_buckets
    @store[modulo].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count == num_buckets
      resize!
    end

    modulo = num % num_buckets
    
    unless self.include?(num)
      @count += 1
      @store[modulo] << num
    end
  end

  def remove(num)
    modulo = num % num_buckets
    if self.include?(num)
      @store[modulo].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    modulo = num % num_buckets 
    store[modulo].include?(num)
  end

  private
  attr_writer :store
  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!(*args)
    if (@count + args.length) >= num_buckets
      temp_arr = @store
      double_buckets = num_buckets * 2
      @store = Array.new(double_buckets) {Array.new}
      temp_arr.each do |bucket|
        bucket.each do |ele|
          modulo = ele % double_buckets
          @store[modulo] << ele
        end
      end
    end

    args.each do |ele| 
      self.insert(ele) 
      @count += 1
    end

    @store
  end
end
