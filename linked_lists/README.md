# Linked list

**linked list** is linear data structure where each element is a separate object (*node*) . Nodes point to the next node by pointer. Every node holds data and link or pointer to the next node in list.

[node(head)] -> [ node ] -> [ node(tail) ] -> nil

### Ruby and linked list
Ruby arrays are not limited by size and with internal c implementation working under the hood they act very similar to a linked list so there may not be use for a linked list in Ruby at all. Goal here was to understand importance of data structures and get better understanding of them, so following TOP assignment I created one using Ruby.

Note that in LinkedList class, class variable ``@head`` is initialized as instance of Node class. This is wrong by definition of linked list, where head is not node by itself, it just holds link to first node. I decided to make it a node just for easier understanding. This can be fixed by initializing head node in class functions. 
Something like this:

```ruby
... 
	def append(value) 
	  node = Node.new(value)
	  ...
	end
...
```

