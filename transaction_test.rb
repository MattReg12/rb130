require 'minitest/autorun'
#require 'minitest/reporters'

#Minitest::Reporters.use!

require_relative 'transaction'
require_relative 'cashregister'


class TransactionTest < Minitest::Test
  def setup
    @register = CashRegister.new(100)
    @transaction = Transaction.new(1000)
  end

  def test_prompt_for_payment
    input = StringIO.new("1100\n")
    @transaction.prompt_for_payment(input: input, output: File.new('test.txt', 'w+'))
    assert_equal(1100, @transaction.amount_paid)
  end
end
