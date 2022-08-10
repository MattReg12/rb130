require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!


class NoExperienceError < StandardError; end

class Employee
  def hire
    raise NoExperienceError
  end
end

class List
  def process
    self
  end
end

class EasyTest < Minitest::Test
  def setup
    @value = rand(1..100)
    @value_two = 'xyz'
    @value_three = nil
    @value_four = []
    @value_five = [1,2,3,'xyz']
    @employee = Employee.new
    @value_seven = 1
    @value_eight = Numeric.new
    @value_nine = 5
    @list = List.new
    @value_ten = [1, 2]
  end

  def test_odd
    assert_equal(true, @value.odd?)
  end

  def test_xyz
    assert_equal('xyz', @value_two.downcase)
  end

  def test_nil
    assert_nil(@value_three)
  end

  def test_empty
    assert_empty(@value_four)
  end

  def test_inlcude_xyz
    assert_includes(@value_five, 'xyz')
  end

  def test_hire
    assert_raises(NoExperienceError) { @employee.hire }
  end

  def test_is_a
    assert_instance_of(Numeric, @value_eight)
  end

  def test_kind_of
    assert_kind_of(Numeric, @value_nine)
  end

  def test_same_object
    assert_same(@list, @list.process)
  end

  def test_shouldnt_be_in_list
    refute_includes(@value_ten, 'xyz')
  end
end
