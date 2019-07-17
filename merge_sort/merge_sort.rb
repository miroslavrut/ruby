def merge_sort( ary)
  return ary if ary.length < 2

  left = merge_sort(ary[0...ary.length/2])
  right = merge_sort(ary[ary.length/2..-1])
  result = Array.new

  until left.empty? || right.empty?
    if left[0] <= right[0]
      result << left.shift
    else
      result << right.shift
    end
  end
  result + left + right
end

a = [2,1,4,5,6,9,3,7,8]

merge_sort(a) # => [1, 2, 3, 4, 5, 6, 7, 8, 9]