require "./stubs_integration"
require "test/unit"
class Check < Test::Unit::TestCase

# This test is for the calculate_total_price method. It will test the integration of
# all the above tests for the result of this one.
  def test_integrate_calculation_methods_1
    x = [["1", "2", "3", "4", "4", "6"], ["1", "2", "3", "4", "8", "6"]]
    assert_equal(23.51, StubIntegration.new.integrate_calculation_methods(x))
  end

# This the same test but sampling with a different set of arrays that more closely
# resemble the data from the products table.
  def test_integrate_calculation_methods_2
    x = [["Router", "3", "Scan", "SLA1", "3", "99.99"], ["PC", "4", "Alert", "SLA2", "6", "199.99"]]
    assert_equal(1044.93, StubIntegration.new.integrate_calculation_methods(x))
  end
end