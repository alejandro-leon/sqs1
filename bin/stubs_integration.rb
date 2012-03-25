require "./discounts"
# This class is basicallly an excerpt from the "Quote" class.
# Its main purpose is to help test the integration of all the stubs involved in the 
# calculation of the total price from all the quote lines created by the user for
# that session.
class StubIntegration


# This is the main method in this class and it will run all the other methods
# secuentially.  The method will receive a sample @quotes array as parameters and
# check the final result for equality after going through all the methods in 
# this class.

  def integrate_calculation_methods(quotesArray)
    @quotes = quotesArray
    self.calculate_subtotal_price
    self.calculate_total_weight
    self.calculate_discount_percent
    self.calculate_discount_price
    self.calculate_total_price
  end

# Calculations
  # Method for calculating the subtotal price of the selected products,
  # which is the total of product prices without subtracting the discount.
  def calculate_subtotal_price
    x = @quotes
    subtotalPrice = 0
  # For each line in the table, subtotalPrice is sum of all the (quantity * price) amounts.
      for i in 0...x.count
      subtotalPrice += (x[i][1].to_i * x[i][5].to_f)#.round(2)
      end
    subtotalPrice # Returns subtotalPrice as a float
  end
  # Method for calculating the discount.  It checks if the total weight of the quote lines 
  # matches any of the thresholds and gets the specified discount percentage for the match.
    # First we find out the total weight of all the devices
  def calculate_total_weight
    x = @quotes
    totalWeight = 0
    for i in 0...x.count
      totalWeight += x[i][4].to_i # The 4th element in each array in array "x" is the weight.
    end
    return totalWeight # This returns an integer
  end
  # Then we find out the discount to the resulting total weight.
  def calculate_discount_percent(n)
    fromDiscounts = Discount.new
    t = n#self.calculate_total_weight
    x = fromDiscounts.get_discount_table  # This is the @discounts array
    tentativeDiscountWeight = 0
    for i in 0...x.count
      if t >= x[i][0].to_i
        if tentativeDiscountWeight < x[i][0].to_i # No matter what order the arrays are in,
          tentativeDiscountWeight = x[i][0].to_i  # this will sort out the highest match.
          discountIndex = i # With this index we can find which array contains the % we want.
        end
      else noDiscount = true # If there are no matches, no discount is given.
      end
    end
    if noDiscount == true
      @finalDiscountPercent = "0"
    else @finalDiscountPercent = x[discountIndex][1]  # Percentage is the 2nd element in each array.
    end
    return @finalDiscountPercent # This returns a string
  end
  # After knowing the percentage, we can figure out what percentage that percentage is
  # in currency amount.
  def calculate_discount_price
    #First turn the discount percent from a string into a float. Then divide it by 100.
    
    percent = (self.calculate_discount_percent).to_f / 100
    # Finally the subtotal price is multiplied by percent to get the total price.
    discountPrice = self.calculate_subtotal_price * percent
    return discountPrice#.round(2) # This returns a float rounded to 2 decimal places
  end
  # Finally, we subtract the discount amount from the subtotal price to get the final price.
  def calculate_total_price
    totalPrice = self.calculate_subtotal_price - self.calculate_discount_price
    return totalPrice.round(2)
  end   
end
