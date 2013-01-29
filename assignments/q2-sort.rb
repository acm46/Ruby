# Will use quick sort implementation

def sort(arr)
  return arr if arr.length <= 1
  less, greater = [], []
  pivot = rand(arr.length)
  for i in 0...arr.length do
  	if i != pivot
  		less.push(arr[i]) if ((arr[i] <=> arr[pivot]) < 1)
  		greater.push(arr[i]) if ((arr[i] <=> arr[pivot]) > 0)
  	end
  end
  return sort(less) + [arr[pivot]] + sort(greater)
end

puts sort([2, 4, 1, 3]) # => [1, 2, 3, 4]
puts sort(['abc', 'ghi', 'def', 'a']) # => ['a', 'abc', 'def', 'ghi']