
def fact(n)
  a = n
  until n == 1
    a *= n-1
    n-=1 
  end
  a
end

# using enumerable (kinda best solution)
def fact2(n)
  (1..n).inject(:*) || 1
end

fact2(4)   # => 24

def factoriel(n)
  n # => 4,     3,     2,     1,     0
  return 1 if n == 0 # => false, false, false, false, true
  factoriel(n-1) * n # => 1, 2, 6, 24
end

factoriel(4) # => 24


###############################################################################

def append(ary, n)
  n   # => 3,     2,     1,      0,         -1
  ary   # => [],    [3],   [3, 2], [3, 2, 1], [3, 2, 1, 0]
  return ary if n < 0   # => false, false, false,  false,     true
  ary << n   # => [3], [3, 2], [3, 2, 1], [3, 2, 1, 0]
  append(ary, n-1)
end

def reverse_append(ary, n)
  n   # => 4,     3,     2,     1,     0,     -1
  return ary if n < 0   # => false, false, false, false, false, true
  reverse_append(ary, n-1) # => [],  [0],    [0, 1],    [0, 1, 2],    [0, 1, 2, 3]
  ary << n   # => [0], [0, 1], [0, 1, 2], [0, 1, 2, 3], [0, 1, 2, 3, 4]
  ary # => [0], [0, 1], [0, 1, 2], [0, 1, 2, 3], [0, 1, 2, 3, 4]
end

reverse_append([], 4)   # => [0, 1, 2, 3, 4]
append([], 3) # => [3, 2, 1, 0]

#############################################################################


def palindrome?(string)
  return true if string.delete(" ") == string.delete(" ").reverse
  false
end

def rec_palindrome?(string)
  return true if string.length == 1 || string.length == 0
  if string[0] == string[-1] 
    rec_palindrome?(string[1..-2])
  else
    false
  end
end

rec_palindrome?('madam')   # => true
rec_palindrome?('nurses run')   # => false
rec_palindrome?('amp')   # => false


palindrome?('madam')   # => true
palindrome?('nurses run')   # => true
palindrome?('amp')   # => false

########################################################################3
def bottles(n)
  if n == 0 
  puts "No more bottles of beer on the wall" 
  else
  puts "#{n} bottles of beer on the wall"   
  bottles(n-1)   
  end
end

bottles(3)  # => nil

# >> 3 bottles of beer on the wall
# >> 2 bottles of beer on the wall
# >> 1 bottles of beer on the wall
# >> No more bottles of beer on the wall



################################################################################
def fib(n)
  a = 0
  b = 1
  n.times do
    temp = a
    a = b
    b = temp + b
  end
  a   # => 3
end
fib(4 )   # => 3

def rec_fib(n)
  n <= 1 ? n : rec_fib(n-1) + rec_fib(n-2)
end

rec_fib(6)   # => 8

##############################################################################

def my_flatten(ary)
  result = Array.new
  ary.each do |el|
    if el.class == Array
      el.each {|val| result << val}
    else
      result << el
    end
  end
  result
end


# if result is in method it wil reset on every call
def rec_flatten(ary, result = [])
  ary.each do |el|
    if el.class == Array
      rec_flatten(el, result)
    else
      result << el
    end
  end
  result
end


recursive_flatten([1,2,[3,4,5]])   # => NoMethodError: undefined method `recursive_flatten' for main:Object\nDid you mean?  rec_flatten
rec_flatten([1,2,[3,4,5]]) # => 

