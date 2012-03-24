require "./quotes2"
require "./quotes"
require "./users"
require "test/unit"
class Check < Test::Unit::TestCase

# Example format for tests to test equivalency:
# assert_equal(expected_value, ClassTested.new(arg1,arg2).method_name_to_test(arg))
# If you want test to fail change expected_value to an incorrect value.

# Test for matching the weight to the discount percent thresholds.
  # Total weight "t" in the original method was replaced by sending a test weight as a parameter.
  # The test asserts that when weight equals "y%", the percent should equal "x",  [x,y%] being the
  # discount parameters retrieved from the discounts.txt file
  def test_total_discount_should_fail_1
      assert_equal("3%", Quote2.new.calculate_total_discount(12))
  end
  def test_total_discount_shoud_fail_2_
      assert_equal("1%", Quote2.new.calculate_total_discount(12))
  end
  def test_total_discount_should_pass
      assert_equal("2%", Quote2.new.calculate_total_discount(12))
  end
=begin
Results of test by applying boundary value analysis:
  Loaded suite tests
  Started
  FF.
  Finished in 0.256 seconds.
  
    1) Failure:
  test_total_discount_shoud_fail_2_(Check)
      [tests.rb:19:in `test_total_discount_shoud_fail_2_'
       org/jruby/RubyKernel.java:2076:in `send'
       org/jruby/RubyArray.java:1615:in `each'
       org/jruby/RubyArray.java:1615:in `each']:
  <"1%"> expected but was
  <"2%">.
  
    2) Failure:
  test_total_discount_should_fail_1(Check)
      [tests.rb:16:in `test_total_discount_should_fail_1'
       org/jruby/RubyKernel.java:2076:in `send'
       org/jruby/RubyArray.java:1615:in `each'
       org/jruby/RubyArray.java:1615:in `each']:
  <"3%"> expected but was
  <"2%">.
  
  3 tests, 3 assertions, 2 failures, 0 errors
  
This confirms that from the 3 assertion tests  the 2 expecting the values of
1% and 3% failed.  This indicate 2% matched the expected result and passed.
=end


# Test for testing the calculate_subtotal_price module
# This gave me a failure, though the calculation was right, the result was the 
# for count and not a number, then when returning subtotalPrice the resulting
# 24 was a float not an integer.  24.0 tested positive. 
# Changed it to 24.0 and passed
=begin
  def test_subtotal
    x = [[1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6]] #sample array
    assert_equal(24.0, Quote.new.calculate_subtotal_price(x))
    # Product quantity is in the second field of each array, price is in the sixth.
    # Should be (2*6) + (2*6) = 24.0
  end
=end
=begin
This is a  sample test result when expected answer 24 instead of 24.0 
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
end

