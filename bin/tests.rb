
require "./quotes"
require "./users"
require "test/unit"
class Check < Test::Unit::TestCase

#Example format for tests.  To test equivalency:
#assert_equal(expected_answer, ClassTested.new(arg1,arg2).method_name_to_test)
#If you want test to fail change correct_answer to incorrect_answer.

# Test for matching range of weights needed for discount


# Test for testing the calculate_subtotal_price module
# This gave me a failure, though the calculation was right, the result was the 
# for count and not a number, then when returning subtotalPrice the resulting
# 24 was a float not an integer.  24.0 tested positive. 
# Changed it to 24.0 and passed
  def test_subtotal
    x = [[1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6]] #sample array
    assert_equal(24.0, Quote.new.calculate_subtotal_price(x))
    # Product quantity is in the second field of each array, price is in the sixth.
    # Should be (2*6) + (2*6) = 24.0
  end
=begin This is a  sample test result when expected answer 24 instead of 24.0 
Test results
 Loaded suite tests
Started
F
Finished in 0.211 seconds.

  1) Failure:
test_subtotal(Check)
    [tests.rb:14:in `test_subtotal'
     org/jruby/RubyKernel.java:2076:in `send'
     org/jruby/RubyArray.java:1615:in `each'
     org/jruby/RubyArray.java:1615:in `each']:
<24> expected but was
<0...1>.

1 tests, 1 assertions, 1 failures, 0 errors 
=end



#require 'test/unit'
#class TestMe < Test::Unit::TestCase
#  def test_add
#    s = 1 + 1
#    assert_equal(2, s)
#  end

end
