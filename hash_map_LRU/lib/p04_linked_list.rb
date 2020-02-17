class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
    # optional but useful, connects previous link to next link
    # and removes self from list.
    prev.next = @next
    @next.prev = prev 
  end
end

class LinkedList

  def initialize
    @head = Node.new 
    @tail = Node.new 
    @head.next = @tail
    @tail.prev = @head 
    
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev 
  end

  def empty?
    (@head.next == @tail) && (@tail.prev == @head)
  end

  def get(key)
    current_node = @head 
    until current_node.next.nil? 
      if current_node.key == key 
        return current_node.val 
      end 
      current_node = current_node.next 
    end

    nil
  end

  def include?(key)
    current_node = @head
    until current_node.next.nil? 
      if current_node.key == key 
        return true 
      end
      current_node = current_node.next 
    end

    false
  end

  def append(key, val)
    node = Node.new(key, val)
    @tail.prev.next = node
    node.next = @tail 
    node.prev = @tail.prev 
    @tail.prev = node  
  end

  def update(key, val)
    current_node = @head 
    until current_node.next.nil? 
      if current_node.key == key 
        current_node.val = val 
      end
      current_node = current_node.next 
    end
  end

  def remove(key)
    current_node = @head
    until current_node.next.nil?
      if current_node.key == key
        current_node.remove
      end
      current_node = current_node.next
    end
  end

  def each(&prc)
    current_node = @head 
    until current_node.next == nil 
      prc.call(current_node) 
      current_node = current_node.next 
    end 
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
