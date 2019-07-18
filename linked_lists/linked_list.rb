class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = Node.new('head', nil)
  end

  def append(value)
    self.tail.next_node = Node.new(value, nil)
  end 

  def prepend(value)
    self.head.next_node = Node.new(value, self.head.next_node)
  end

  def size
    if self.head.next_node
      node = self.head.next_node
      i = 1
      while node.next_node
        node = node.next_node
        i += 1
      end
      return i
    else 
      return 0
    end
  end

  def head
    @head
  end

  def tail
    if self.head.next_node
      node = self.head.next_node
      while node.next_node
        node = node.next_node
      end
      node
    else
      @head
    end
  end

  def pop
    if self.head.next_node
      node = self.head.next_node
      while node.next_node.next_node
        node = node.next_node
      end
      popping = node.next_node
      node.next_node = nil
      return popping
    else
      return nil
    end
  end

  def contains?(value)
    if self.head.next_node
      node = self.head.next_node
      while node.next_node
        if node.value == value
          return true
        else
          node = node.next_node
        end
      end
      return false
    else
      return false
    end
  end

  def find(value)
		if @head.next_node
			node = @head.next_node
			i = 0
			while node.next_node
				if node.value == value
					return i
				else
					node = node.next_node
					i += 1
				end
			end
			return nil
		else
			return nil
		end
  end

  def to_s
    if self.head.next_node
      s = "(#{@head.next_node.value}) -> "
      node = self.head.next_node
      while node.next_node
        s += "(#{node.next_node.value}) -> "
        node = node.next_node
      end
      s += "nil"
      return s
    else
      return "nil"
    end
  end

  def at(index)
    if self.size > index
      if self.head.next_node
        node = self.head.next_node
        i = 0
        until i == index
          node = node.next_node
          i += 1
        end
        return node
      else
        return nil
      end
    end
    return nil
  end

	def insert_at(index,value)
		self.at(index-1).next_node = Node.new(value,self.at(index-1).next_node)
	end

	def remove_at(index)
		self.at(index-1).next_node = self.at(index).next_node
	end
end

a = LinkedList.new   # => #<LinkedList:0x000055dc61afacd8 @head=#<Node:0x000055dc61af9ec8 @value="head", @next_node=nil>>
a.append(3)   # => #<Node:0x000055dc61b023c0 @value=3, @next_node=nil>
a.append(4)   # => #<Node:0x000055dc61b979c0 @value=4, @next_node=nil>

a   # => #<LinkedList:0x000055dc61afacd8 @head=#<Node:0x000055dc61af9ec8 @value="head", @next_node=#<Node:0x000055dc61b023c0 @value=3, @next_node=#<Node:0x000055dc61b979c0 @value=4, @next_node=nil>>>>

a.pop   # => #<Node:0x000055dc61b979c0 @value=4, @next_node=nil>

a # => #<LinkedList:0x000055dc61afacd8 @head=#<Node:0x000055dc61af9ec8 @value="head", @next_node=#<Node:0x000055dc61b023c0 @value=3, @next_node=nil>>>

a.prepend(2)    # => #<Node:0x000055dc61b94b58 @value=2, @next_node=#<Node:0x000055dc61b023c0 @value=3, @next_node=nil>>

a # => #<LinkedList:0x000055dc61afacd8 @head=#<Node:0x000055dc61af9ec8 @value="head", @next_node=#<Node:0x000055dc61b94b58 @value=2, @next_node=#<Node:0x000055dc61b023c0 @value=3, @next_node=nil>>>>
a.size # => 2

a.find(4)   # => nil
a.append(4)
a.size    # => 3
a.find(3)   # => 1

a.insert_at(1,5)   # => #<Node:0x000055dc61c06028 @value=5, @next_node=#<Node:0x000055dc61b023c0 @value=3, @next_node=#<Node:0x000055dc61c06b68 @value=4, @next_node=nil>>>