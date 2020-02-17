class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count >= num_buckets
      resize!
    end
    
    self[key] << key
    @count += 1
    return true
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!(*arg)
    org_store = @store
    @store = Array.new(num_buckets * 2) { Array.new()}
    
    org_store.each do |bucket|
      bucket.each do |ele|
        modulo = ele.hash % num_buckets
        @store[modulo] << ele
      end
    end

    arg.each do |ele|
      modulo = ele.hash % num_buckets
      @store[modulo] << ele
      @count += 1
    end
  end
end
