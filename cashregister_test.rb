require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!

require_relative 'cashregister'
require_relative 'transaction'


class CashRegisterTest < Minitest::Test
  def setup
    @register = CashRegister.new(100)
    @transaction = Transaction.new(50)
    @transaction.amount_paid = 10
  end

  def test_accept_money
    @register.accept_money(@transaction)
    assert_equal(110, @register.total_money)
  end

  def test_change
    assert_equal(-40, @register.change(@transaction))
    @transaction.amount_paid = 1000
    assert_equal(950, @register.change(@transaction))
  end

  def test_give_receipt
    #output = capture_io { @register.give_receipt(@transaction) }
    assert_output("You've paid $50.\n") { @register.give_receipt(@transaction) }
  end
end
