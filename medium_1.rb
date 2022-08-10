#1)

class Device
  def initialize
    @recordings = []
  end

  def listen
    return if !block_given?

    @recordings << yield
  end

  def play
    puts @recordings.last
  end
end

# listener = Device.new
# listener.listen { "Hello World!" }
# listener.listen
# listener.play # Outputs "Hello World!"

#2)

class TextAnalyzer
  def self.process(file)
    file = File.new(file).read
    puts "#{file.split("\n\n").size} paragraphs"
    puts "#{file.split("\n").size} lines"
    puts "#{file.split.size} words"
  end
end

# TextAnalyzer.process('sample.txt')

#3)

# items = ['apples', 'corn', 'cabbage', 'wheat']

# def gather(items)
#   puts "Let's start gathering food."
#   items.each { |item| yield(item) }
#   puts "Nice selection of food we have gathered!"
# end

# #4)

# def awry(arr)
#   yield(arr)
# end


#5)

items = ['apples', 'corn', 'cabbage', 'wheat']

# def gather(items)
#   puts "Let's start gathering food."
#   yield(items)
#   puts "We've finished gathering!"
# end

# #a)

# gather(items) do |*first, last|
#   puts first.join(', ')
#   puts last
# end

# #b)

# gather(items) do |first, *mid, last|
#   puts first
#   puts mid.join(', ')
#   puts last
# end

# #c)

# gather(items) do |first, *last|
#   puts first
#   puts last.join(', ')
# end

# #d)

# gather(items) do |a, b, c, d|
#   puts [a,b,c,d].join(', ')
# end

#6)

# Replace the two `method_name` placeholders with actual method calls
def convert_to_base_8(n)
  n.to_s(8).to_i
end

# Replace `argument` with the correct argument below
# `method` is `Object#method`, not a placeholder
base8_proc = method(:convert_to_base_8).to_proc

# We'll need a Proc object to make this code work
# Replace `a_proc` with the correct object
x = [8, 10, 12, 14, 16, 33].map(&base8_proc)



#7)

def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given?
        next if yield(array[index - 1], array[index])
        array[index - 1], array[index] = array[index], array[index - 1]
        swapped = true
      else
        next if array[index - 1] <= array[index]
        array[index - 1], array[index] = array[index], array[index - 1]
        swapped = true
      end
    end

    break unless swapped
  end
  nil
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
p array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
p array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
p array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)
