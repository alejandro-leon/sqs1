require "./stubs_unit"
require "test/unit"
class Check < Test::Unit::TestCase

# The tests in this file will test every unit of the calculation methods in the
# "stubs_unit.rb" file individually.
# Note that the tests results show that the tests did not fail with the data given,
# The expected value of the tests was modified to incorrect date to see how the test failed.
# A sample of some failed results is given for the test_subtotal_price.

# Example format for tests to test equivalency:
# assert_equal(expected_value, ClassTested.new(arg1,arg2).method_name_to_test(arg))
# The expected_value should be replaced with incorrect values to see how the test fails
# before entering the correct values.

# Test for testing the calculate_subtotal_price module.
# At first expected_value was tested with the number 24 (integer), this gave a failure.
# The second try, the integer 24 was replaced by 24.0 (float). Test passed
  def test_subtotal_price
    x = [[1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6]] #sample array used as productTable
    assert_equal(24.0, Stub.new.calculate_subtotal_price(x))
    # Product quantity is in the second field of each array. 
    # The price of each product is in the sixth.
    # Should be (2*6) + (2*6) = 24.0
  end  
=begin  
#This is a  sample test result when expected_value was 24 (integer):
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
  
# Here is the same test with expected_value being 24.0 (which is a float):
  Loaded suite tests
  Started
  .
  Finished in 0.056000 seconds.
  
  1 tests, 1 assertions, 0 failures, 0 errors, 0 skips
  
  Test run options: --seed 35797
=end

  def test_calculate_total_weight
    x = [[1, 3, 3, 4, 2, 6], [1, 2, 3, 4, 3, 6]] #sample array used as productTable
    assert_equal(12, Stub.new.calculate_total_weight(x))
  end
=begin
Results
  Loaded suite tests_unit
  Started
  .
  Finished in 0.074000 seconds.
  
  1 tests, 1 assertions, 0 failures, 0 errors, 0 skips
  
  Test run options: --seed 47921
=end

# Test for matching the weight to the discount percent thresholds.
  # Total weight "t" in the original method was replaced by sending a test weight as a parameter.
  # The test asserts that when weight equals "y%", the percent should equal "x",  [x,y%] being the
  # discount parameters retrieved from the discounts.txt file
  def test_discount_percent_should_fail_1
      assert_equal("1%", Stub.new.calculate_discount_percent(12))
  end
  def test_discount_percent_shoud_fail_2_
      assert_equal("3%", Stub.new.calculate_discount_percent(12))
  end
  def test_discount_percent_should_pass
      assert_equal("2%", Stub.new.calculate_discount_percent(12))
  end
=begin
Results of test by applying boundary value analysis:
  Loaded suite tests
  Started
  FF.
  Finished in 0.256 seconds.
  
    1) Failure:
  test_discount_percent_shoud_fail_2_(Check)
      [tests.rb:19:in `test_discount_percent_shoud_fail_2_'
       org/jruby/RubyKernel.java:2076:in `send'
       org/jruby/RubyArray.java:1615:in `each'
       org/jruby/RubyArray.java:1615:in `each']:
  <"1%"> expected but was
  <"2%">.
  
    2) Failure:
  test_discount_percent_should_fail_1(Check)
      [tests.rb:16:in `test_discount_percent_should_fail_1'
       org/jruby/RubyKernel.java:2076:in `send'
       org/jruby/RubyArray.java:1615:in `each'
       org/jruby/RubyArray.java:1615:in `each']:
  <"3%"> expected but was
  <"2%">.
  
  3 tests, 3 assertions, 2 failures, 0 errors
  
This confirms that from the 3 assertion tests  the 2 expecting the values of
1% and 3% failed.  This indicate 2% matched the expected result and passed.
=end

# Test for the calculate_discount_price method
  def test_discount_price
    assert_equal(0.48, Stub.new.calculate_discount_price("2%",24.0))
  end
=begin
Results:
  Loaded suite tests
  Started
  .
  Finished in 0.085000 seconds.
  
  1 tests, 1 assertions, 0 failures, 0 errors, 0 skips
  
  Test run options: --seed 31418
=end

# This test is for the calculate_total_price method. It will test the integration of
# all the above tests for the result of this one.
  def test_calculate_total_price
    assert_equal(23.52, Stub.new.calculate_total_price(24.0,0.48))
  end
=begin
Results:
Loaded suite tests
Started
.
Finished in 0.096000 seconds.

1 tests, 1 assertions, 0 failures, 0 errors, 0 skips

Test run options: --seed 42460
=end

end