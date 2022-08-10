#1)

def new_step(start, stop, step)
  current = start
  until current > stop
    yield(current) if block_given?
    current += step
  end
  (start..stop)
end

# new_step(1,10,3) { |num| puts num }


#2)

def new_zip(arr1, arr2)
  arr1.each_with_object([]).with_index do |(element, zipped), i|
    zipped << [element, arr2[i]]
  end
end


# p new_zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

#3)

def new_map(arr)
  i = 0
  new_arr = []
  until i >= arr.size
    new_arr[i] = yield(arr[i]) if block_given?
    i += 1
  end
  new_arr
end

# p new_map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
# p new_map([]) { |value| true } == []
# p new_map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
# p new_map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
# p new_map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]

#4)

def new_count(*args)
  i = 0
  count = 0
  until i == args.size
    count += 1 if yield(args[i])
    i += 1
  end
  count
end

# p new_count(1, 3, 6) { |value| value.odd? } == 2
# p new_count(1, 3, 6) { |value| value.even? } == 1
# p new_count(1, 3, 6) { |value| value > 6 } == 0
# p new_count(1, 3, 6) { |value| true } == 3
# p new_count() { |value| true } == 0
# p new_count(1, 3, 6) { |value| value - 6 } == 3

#5)

=begin

P: take a collection, pass each element to block until block returns falsey,
   return that element + remaining elements.

E: return empty array if all truthy

D: arrays

A:

=end

def drop_while(arr)
  i = 0
  until i == arr.size
   break unless yield(arr[i])
   i += 1
  end
  arr[i..-1]
end

# p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
# p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
# p drop_while([1, 3, 5, 6]) { |value| true } == []
# p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
# p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
# p drop_while([]) { |value| true } == []

#6)

def new_each_with_index(arr)
  i = 0
  until i == arr.size
    yield(arr[i], i)
    i += 1
  end
  arr
end

# result = new_each_with_index([1, 3, 6]) do |value, index|
#   puts "#{index} -> #{value**index}"
# end

# puts result == [1, 3, 6]

#7)

def new_each_with_object(arr, obj)
  i = 0
  until i == arr.size
    yield(arr[i], obj)
    i += 1
  end
  obj
end

# result = new_each_with_object([1, 3, 5], []) do |value, list|
#   list << value**2
# end
# p result == [1, 9, 25]

# result = new_each_with_object([1, 3, 5], []) do |value, list|
#   list << (1..value).to_a
# end
# p result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

# result = new_each_with_object([1, 3, 5], {}) do |value, hash|
#   hash[value] = value**2
# end
# p result == { 1 => 1, 3 => 9, 5 => 25 }

# result = new_each_with_object([], {}) do |value, hash|
#   hash[value] = value * 2
# end
# p result == {}

#8)

def max_by(arr)
  max = arr.first
  max_value = yield(max) unless arr.empty?
  i = 0
  until i == arr.size
    current_value = yield(arr[i])
    max, max_value = arr[i], current_value if current_value > max_value
    i += 1
  end
  max
end

# p max_by([1, 5, 3]) { |value| value + 2 } == 5
# p max_by([1, 5, 3]) { |value| 9 - value } == 1
# p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
# p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
# p max_by([-7]) { |value| value * 3 } == -7
# p max_by([]) { |value| value + 5 } == nil

#9)

def each_cons(arr)
  i = 0
  until i >= (arr.size - 1)
    yield(arr[i], arr[i + 1])
    i += 1
  end
  nil
end

# hash = {}
# result = each_cons([1, 3, 6, 10]) do |value1, value2|
#   hash[value1] = value2
# end
# p result == nil
# p hash == { 1 => 3, 3 => 6, 6 => 10 }

# hash = {}
# result = each_cons([]) do |value1, value2|
#   hash[value1] = value2
# end
# p hash == {}
# p result == nil

# hash = {}
# result = each_cons(['a', 'b']) do |value1, value2|
#   hash[value1] = value2
# end
# p hash == {'a' => 'b'}
# p result == nil

#10)

def each_cons(arr, slice_size)
  slice_size -= 1
  i = 0
  until i >= (arr.size - slice_size)
    slice_size.positive? ? yield(arr[i..(i + slice_size)]) : yield(arr[i])
    i += 1
  end
  nil
end

hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
p hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, *values|
  hash[value1] = values
end
p hash == {}
