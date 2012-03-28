require "./data/discounts"

# This file contains a copy of the methods containing different calculation
# algorithms for the program.
# Each method here was modified to be tested individually with the tests included
# in the accompanying test file "tests.unit.rb" runs with the Unit::Test library.
# Some of these methods require access to the discounts.txt file for data.

class Stub
=begin
=end
  def calculate_total_weight(quotesTable)  # Sample quotes table.
    x = quotesTable
    totalWeight = 0
    for i in 0...x.count
      # Multiply the 5th element (weight) to the 2nd element (quantity) to get the total
      # of each quote line and then add them together.
      totalWeight += (x[i][4].to_i * x[i][1].to_i)
    end                                            
    return totalWeight # This returns an integer
  end
=begin 
=end
  def calculate_discount_percent(w)  # w is the sample weight.
    fromDiscounts = Discount.new
    #w = self.calculate_total_weight
    x = fromDiscounts.get_discount_table  # This is the @discounts array.
    tentativeDiscountWeight = 0
    for i in 0...x.count
      if w >= x[i][0].to_i
        if tentativeDiscountWeight < x[i][0].to_i # No matter what order the arrays are in,
          tentativeDiscountWeight = x[i][0].to_i  # this will sort out the highest match.
          discountIndex = i # With this we can find which array contains the % we want.
        end
      end
    end
    # If there are no matches, tentativeDiscount remains = 0 and no discount is given.
    if tentativeDiscountWeight == 0
      @finalDiscountPercent = "0%"
    else @finalDiscountPercent = x[discountIndex][1]  # Percentage is the 2nd element in each array.
    end
    return @finalDiscountPercent # This returns a string.
  end

=begin
=end
  def calculate_subtotal_price(productTable)
    x = productTable
    subtotalPrice = 0
  # For each line in the table, subtotalPrice is sum of all the (quantity * price) amounts.
      for i in 0...x.count
      subtotalPrice += (x[i][1].to_i * x[i][5].to_f).round(2)
      end
    subtotalPrice
  end
=begin
=end
  def calculate_discount_price(discount_percent,subtotal_price)
    #First turn the discount percent from a string into a float. Then divide it by 100.
    percent = (discount_percent).to_f / 100
    # Finally the subtotal price is multiplied by percent to get the total price.
    discountPrice = subtotal_price * percent
    return discountPrice # This returns a float
  end

=begin
=end
  def calculate_total_price(subtotal_price,discount_price)
    totalPrice = subtotal_price - discount_price 
  end    

end