require "./stubs_integration"
require "test/unit"
class Check < Test::Unit::TestCase
  
# The tests in this file will test the integration of the calculation methods in the
# "stubs_integration.rb" file.
# Note that the tests results show that the tests did not fail with the data given,
# The expected value of the tests was modified to incorrect date to see how the test failed.
# A sample of the failed results is given at the end of the test file.


   # This tests the integration of the two calculation methods that figure out the
   #discount percent by sending a sample array to confirm equality to the string 
   # containing the % sign.
  def test_integrate_calculation_methods_1a
    x = [["a", "3", "x", "p", "2", "6"], ["b", "2", "y", "q", "3", "6"]]
    assert_equal("2%", StubIntegration.new.integrate_calculation_methods_1(x))
  end
  def test_integrate_calculation_methods_1b
    x = [["Router", "3", "Scan", "SLA1", "3", "99.99"], ["PC", "4", "Alert", "SLA2", "6", "199.99"]]
    assert_equal("5%", StubIntegration.new.integrate_calculation_methods_1(x))
  end
=begin
Results:
  Loaded suite tests_integration
  Started
  ..
  Finished in 0.206000 seconds.
  
  2 tests, 2 assertions, 0 failures, 0 errors, 0 skips
  
  Test run options: --seed 29817
=end

  # This test is for the calculate_total_price method. It will test the integration of
  # all the above tests for the result 23.51 with the sample x array.
  def test_integrate_calculation_methods_2a
    x = [["a", "2", "x", "p", "5", "6"], ["b", "2", "y", "q", "5", "6"]]
    assert_equal(23.53, StubIntegration.new.integrate_calculation_methods_2(x))
  end

  # This is the same test but sampling with a different set of arrays that more closely
  # resemble the data from the products table.
  def test_integrate_calculation_methods_2b
    x = [["Router", "3", "Scan", "SLA1", "3", "99.99"], ["PC", "4", "Alert", "SLA2", "6", "199.99"]]
    assert_equal(1044.92, StubIntegration.new.integrate_calculation_methods_2(x))
  end
=begin
Results:
Loaded suite tests_integration
Started
..
Finished in 0.191000 seconds.

2 tests, 2 assertions, 0 failures, 0 errors, 0 skips

Test run options: --seed 3182
=end
=begin
Sample of failed results by changing expected values to incorrect values:
  Loaded suite tests_integration
  Started
  FF
  Finished in 0.218000 seconds.
  
    1) Failure:
  test_integrate_calculation_methods_2a(Check) [tests_integration.rb:39]:
  <23.53> expected but was
  <23.52>.
  
    2) Failure:
  test_integrate_calculation_methods_2b(Check) [tests_integration.rb:46]:
  <1044.92> expected but was
  <1044.93>.
  
  2 tests, 2 assertions, 2 failures, 0 errors, 0 skips
  
  Test run options: --seed 53162
=end

end