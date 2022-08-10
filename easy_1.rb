#2)


# def compute(arg)
#   return yield(arg) if block_given?
#   'Does not compute.'
# end


# p compute { 5 + 3 } == 8
# p compute { 'a' + 'b' } == 'ab'
# p compute == 'Does not compute.'


#3)

=begin
Write a method that takes a sorted array of integers as an argument,
and returns an array that includes all of the missing integers (in order)
between the first and last elements of the argument
=end

# def missing(arr)
#   (arr.first..arr.last).to_a - arr
# end

# p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
# p missing([1, 2, 3, 4]) == []
# p missing([1, 5]) == [2, 3, 4]
# p missing([6]) == []


#4)

def divisors(int)
  return [1] if int == 1

  divisors = []
  num = 1
  until (int / num) < num
    if (int % num).zero?
      divisors << num
      divisors << (int / num)
    end
    num += 1
  end
  divisors.sort
end

# p divisors(1) == [1]
# p divisors(7) == [1, 7]
# p divisors(12) == [1, 2, 3, 4, 6, 12]
# p divisors(98) == [1, 2, 7, 14, 49, 98]
# p divisors(999962000357)

#5)

ALPHABET = ('a'..'z').to_a

def rot_thirteen(name)
  arr = name.chars.map do |char|
    if ALPHABET.index(char.downcase).nil?
      char
    else
      new_i = (ALPHABET.index(char.downcase) + 13) % 26
      char.upcase == char ? ALPHABET[new_i].upcase : ALPHABET[new_i]
    end
  end
  arr.join
end


# p rot_thirteen('Nqn Ybirynpr')
# p rot_thirteen('Tenpr Ubccre')
# p rot_thirteen('Nqryr Tbyqfgvar')
# p rot_thirteen('Nyna Ghevat')
# p rot_thirteen('Puneyrf Onoontr')
# p rot_thirteen('Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv')
# p rot_thirteen('Wbua Ngnanfbss')
# p rot_thirteen('Ybvf Unvog')
# p rot_thirteen('Pynhqr Funaaba')
# p rot_thirteen('Fgrir Wbof')
# p rot_thirteen('Ovyy Tngrf')
# p rot_thirteen('Gvz Orearef-Yrr')
# p rot_thirteen('Fgrir Jbmavnx')
# p rot_thirteen('Xbaenq Mhfr')
# p rot_thirteen('Fve Nagbal Ubner')
# p rot_thirteen('Zneiva Zvafxl')
# p rot_thirteen('Lhxvuveb Zngfhzbgb')
# p rot_thirteen('Unllvz Fybavzfxv')
# p rot_thirteen('Tregehqr Oynapu')


#6)

def any?(collection)
  return true if !block_given?

  i = 0
  until i == collection.size
    return true if yield(collection[i])

    i += 1
  end
  false
end

# p any?([1, 3, 5, 6]) { |value| value.even? } == true
# p any?([1, 3, 5, 7]) { |value| value.even? } == false
# p any?([2, 4, 6, 8]) { |value| value.odd? } == false
# p any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
# p any?([1, 3, 5, 7]) { |value| true } == true
# p any?([1, 3, 5, 7]) { |value| false } == false
# p any?([]) { |value| true } == false


#7)

def all?(collection)
  return true if !block_given?

  i = 0
  until i == collection.size
    return false if !yield(collection.to_a[i])

    i += 1
  end
  true
end

# p all?({ 1 => 1, 2 => 2}) { |key, value| key == value } == true
# p all?([1, 3, 5, 7]) { |value| value.odd? } == true
# p all?([2, 4, 6, 8]) { |value| value.even? } == true
# p all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
# p all?([1, 3, 5, 7]) { |value| true } == true
# p all?([1, 3, 5, 7]) { |value| false } == false
# p all?([]) { |value| false } == true

#8)

def none?(collection)
  return false if !block_given?

  i = 0
  until i == collection.size
    return false if yield(collection.to_a[i])

    i += 1
  end
  true
end

# p none?([1, 3, 5, 6]) { |value| value.even? } == false
# p none?([1, 3, 5, 7]) { |value| value.even? } == true
# p none?([2, 4, 6, 8]) { |value| value.odd? } == true
# p none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
# p none?([1, 3, 5, 7]) { |value| true } == false
# p none?([1, 3, 5, 7]) { |value| false } == true
# p none?([]) { |value| true } == true

#9)

def one?(collection)
  i = 0
  counter = 0
  until i == collection.size
    counter += 1 if yield(collection.to_a[i])
    i += 1
  end
  counter == 1
end

# p one?([1, 3, 5, 6]) { |value| value.even? }    # -> true
# p one?([1, 3, 5, 7]) { |value| value.odd? }     # -> false
# p one?([2, 4, 6, 8]) { |value| value.even? }    # -> false
# p one?([1, 3, 5, 7]) { |value| value % 5 == 0 } # -> true
# p one?([1, 3, 5, 7]) { |value| true }           # -> false
# p one?([1, 3, 5, 7]) { |value| false }          # -> false
# p one?([]) { |value| true }                     # -> false

#10)

=begin

p: Given an array and a block. Return the number of times the block evaluates
truthy for each element in the array


e:


d: array, returns int, block


a:
set up a manual index at 0
set up a counter
loop
  yield to the block at the arr at index
  if this block is true counter + 1
  index + 1
  end the loop of the index is equal to size

  return counter


=end

def count(arr)
  arr.reduce(0) { |sum, item| sum = yield(item) ? sum + 1 : sum }
end

p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2
