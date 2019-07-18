class Node
  attr_accessor :value, :pointer

  def initialize(value = nil, pointer = nil)
    @value = value
    @pointer = pointer
  end
end

class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
  end

  def append(value)
    self.tail.pointer = Node.new(value, nil)
  end 


  def prepend(value)
    self.head.pointer = Node.new(value, self.head.pointer)
  end

  def size
    if self.head.pointer
      node = self.head.pointer
      i = 1
      while node.pointer
        node = node.pointer
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
    if self.head.pointer
      node = self.head.pointer
      while node.pointer
        node = node.pointer
      end
      node
    else
      @head
    end
  end

  def pop
    if self.head.pointer
      node = self.head.pointer
      while node.pointer.pointer
        node = node.pointer
      end
      popping = node.pointer
      node.pointer = nil
      return popping
    else
      return nil
    end
  end

  def contains?(value)
    if self.head.pointer
      node = self.head.pointer
      while node.pointer
        if node.value == value
          return true
        else
          node = node.pointer
        end
      end
      return false
    else
      return false
    end
  end

  def find(value)
		if @head.pointer
			node = @head.pointer
			i = 0
			while node.pointer
				if node.value == value
					return i
				else
					node = node.pointer
					i += 1
				end
			end
			return nil
		else
			return nil
		end
  end

  def to_s
		if @head.pointer
			s = "(#{@head.pointer.value}) -> "
			node = @head.pointer
			while node.pointer
				s += "(#{node.pointer.value}) -> "
				node = node.pointer
			end
			s += "nil"
			return s
		else
			return "nil"
		end
	end

	def at(index)
		if self.size > index
			if @head.pointer
				node = @head.pointer
				i = 0
				until i == index
					node = node.pointer
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
		self.at(index-1).pointer = Node.new(value,self.at(index-1).pointer)
	end

	def remove_at(index)
		self.at(index-1).pointer = self.at(index).pointer
	end
end

