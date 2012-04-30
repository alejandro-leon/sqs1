load "./stubs_integration.rb"
require "test/unit"
class Check < Test::Unit::TestCase
  
# The tests in this file test the integration of the calculation methods found in the
# "stubs_integration.rb" file.
# Note that the tests results show that the tests passed with the correct expected data given,
# The expected value of the tests was modified to incorrect data to see how the tests failed.
# Equivalence partitioning and boundary value analysis were used to choose the test data.
# A sample of the some results is given after each test module.
# A sample of failed results is given at the end of the test file.

=begin
   # This tests the integration of the two calculation methods that figure out the
   #discount percent by sending a sample array to confirm equality of the expected data
   # which is the string containing the % sign.
  def test_integrate_calculation_methods_1a
    x = [["a", "3", "x", "p", "2", "6"], ["b", "2", "y", "q", "3", "6"]]
    assert_equal("2%", StubIntegration.new.integrate_calculation_methods_1(x))
  end
  def test_integrate_calculation_methods_1b
    x = [["Router", "3", "Scan", "SLA1", "3", "99.99"], ["PC", "4", "Alert", "SLA2", "6", "199.99"]]
    assert_equal("5%", StubIntegration.new.integrate_calculation_methods_1(x))
  end

Results:
  Loaded suite tests_integration
  Started
  ..
  Finished in 0.206000 seconds.
  
  2 tests, 2 assertions, 0 failures, 0 errors, 0 skips
  
  Test run options: --seed 29817
=end

  # This test is for the calculate_total_price method in the stubs_integration.rb file.
  # It will test the integration of all the above tests for the result 23.51 with the sample x array.
  def test_integrate_calculation_methods_2a
    x = [["a", "2", "x", "p", "5", "6"], ["b", "2", "y", "q", "5", "6"]]
    assert_equal(26.58, StubIntegration.new.integrate_calculation_methods_2(x))
  end

  # This is the same test but sampling with a different set of arrays that more closely
  # resemble the data from the products table.
  def test_integrate_calculation_methods_2b
    x = [["Router", "3", "Scan", "SLA1", "3", "99.99"], ["PC", "4", "Alert", "SLA2", "6", "199.99"]]
    assert_equal(1180.77, StubIntegration.new.integrate_calculation_methods_2(x))
  end
=begin
Results:
  Loaded suite tests_integration
  Started
  ..
  Finished in 0.188000 seconds.
  
  2 tests, 2 assertions, 0 failures, 0 errors, 0 skips
  
  Test run options: --seed 10491
=end
# Sample of failed results by changing expected values to incorrect values:
=begin
# Results from testing top boundary values:

  Loaded suite tests_integration
  Started
  FF
  Finished in 0.248000 seconds.
  
    1) Failure:
  test_integrate_calculation_methods_2a(Check) [tests_integration.rb:41]:
  <26.59> expected but was
  <26.58>.
  
    2) Failure:
  test_integrate_calculation_methods_2b(Check) [tests_integration.rb:48]:
  <1180.78> expected but was
  <1180.77>.
  
  2 tests, 2 assertions, 2 failures, 0 errors, 0 skips
  
  Test run options: --seed 62403

# Results from testing bottom boundary values:
  Loaded suite tests_integration
  Started
  FF
  Finished in 0.386000 seconds.
  
    1) Failure:
  test_integrate_calculation_methods_2a(Check) [tests_integration.rb:41]:
  <26.57> expected but was
  <26.58>.
  
    2) Failure:
  test_integrate_calculation_methods_2b(Check) [tests_integration.rb:48]:
  <1180.76> expected but was
  <1180.77>.
  
  2 tests, 2 assertions, 2 failures, 0 errors, 0 skips
  
  Test run options: --seed 64729
=end

end