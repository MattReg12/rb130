require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!

require_relative 'text'

class TextTest < Minitest::Test
  def setup
    @text = Text.new(File.read('test.txt'))
  end

  def test_swap
    # test_one = Text.new(temp.swap('i', 'a'))
    # assert_equal(@text.text, test_one.text)
  end
end
