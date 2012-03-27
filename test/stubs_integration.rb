require "../data/discounts"
# This class is basicallly an excerpt from the "Quote" class.
# Its main purpose is to help test the integration of all the stubs involved in the 
# calculation of the total price from all the quote lines created by the user for
# that session.
# It contains the algorithms to be tested in sequence by the several tests found in the
# "tests_integration.rb" file run by the Test::Unit library and it requires access to the
# "discounts.txt" file.
# Following are the same methods tested individually by the "tests_unit.rb", but here
# none of the methods is modified.  They will run sequentially as intended in the progam,
# activated by two integration methods.

class StubIntegration

# This method integrates the calculation methods related to figuring out the
# discount price from the sample @quoteLines array.
  def integrate_calculation_methods_1(quotesArray)
    @quoteLines = quotesArray
    self.calculate_total_weight
    self.calculate_discount_percent
  end
  
# This is the main method in this class and it will run all the following methods
# secuentially.  The method will receive a sample @quoteLines array as parameters and
# check the final result for equality after going through all the methods in 
# this class.
  def integrate_calculation_methods_2(quoteLinesArray)
    @quoteLines = quoteLinesArray
    self.calculate_subtotal_price
    self.calculate_total_weight
    self.calculate_discount_percent
    self.calculate_discount_price
    self.calculate_total_price
    self.calculate_tax_price
  end

# Calculations
  # These group of methods get necessary values from the data entered by the user in the
  # @quoteLines array, which contains all the recently entered data arranged in arrays   
  # of quote lines.

# Method for calculating the subtotal price of the selected products,
# which is the total of product prices without subtracting the discount.
  def calculate_subtotal_price
    x = @quoteLines
    subtotalPrice = 0
  # SubtotalPrice is sum of all the (quantity * price) amounts in each line of the table.
      for i in 0...x.count
      subtotalPrice += (x[i][1].to_i * x[i][5].to_f)#.round(2)
      end
    return subtotalPrice # Returns subtotalPrice as a float
  end
# Method to help calculate the discount.  It checks if the total weight of the quote lines 
# matches any of the thresholds set in the "discounts.txt" file and gets the specified
# discount percentage for the match.
# First we find out the total weight of all the devices.
  def calculate_total_weight
    x = @quoteLines
    totalWeight = 0
    for i in 0...x.count
      # Multiply the 5th element (weight) to the 2nd element (quantity) to get the total
      # of each quote line and then add them together one by one to the total weight.
      totalWeight += (x[i][4].to_i * x[i][1].to_i)
    end
    return totalWeight # This returns an integer
  end
# Then find out the discount to the resulting total weight.
  def calculate_discount_percent
    fromDiscounts = Discount.new
    w = self.calculate_total_weight # Total weight calculated before.
    x = fromDiscounts.get_discount_table  # This is the @discounts array.
    tentativeDiscountWeight = 0
    for i in 0...x.count
      if w >= x[i][0].to_i
        if tentativeDiscountWeight < x[i][0].to_i # No matter what order the arrays are in,
          tentativeDiscountWeight = x[i][0].to_i  # this will sort out the highest match.
          discountIndex = i # With this index we can find which array contains the % wanted.
        end
      end
    end
    # If there are no matches, tentativeDiscount remains = 0 and no discount is given.
    if tentativeDiscountWeight == 0
      @finalDiscountPercent = "0%"
    else @finalDiscountPercent = x[discountIndex][1]  # Percentage is the 2nd array element.
    end
    return @finalDiscountPercent # This returns a string.
  end
# After finding the percentage, percentage is converted to its currency value.
  def calculate_discount_price
    #First turn the discount percent from a string into a float. Then divide it by 100.
    percent = (self.calculate_discount_percent).to_f / 100
    # Finally the subtotal price is multiplied by percent to get the total price.
    discountPrice = self.calculate_subtotal_price * percent
    return discountPrice # This returns a float.
  end
# Later, the discount amount is subtracted from the subtotal price to get the total.
  def calculate_total_price
    totalPrice = self.calculate_subtotal_price - self.calculate_discount_price
    return totalPrice.round(2) # This returns a float
  end
# Figures out the sales tax, simple multiply and divide.  Added to total if needed.
  def calculate_tax_price
    tax = 13 * self.calculate_total_price / 100
    return tax # Returns float
  end
end
