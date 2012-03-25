require "./discounts"
class Stub

  def calculate_total_weight(quotesTable)
    x = quotesTable
    totalWeight = 0
    for i in 0...x.count
      totalWeight += x[i][4].to_i # The 4th element in each array in array "x" is the weight.
    end
    return totalWeight # This returns an integer
  end
 
=begin
  def calculate_discount_percent(t)
    fromDiscounts = Discount.new
    #t = self.calculate_total_weight
    x = fromDiscounts.get_discount_table  # This is the discounts array
    tentativeDiscountWeight = 0
    for i in 0...x.count
      if t >= x[i][0].to_i
        if tentativeDiscountWeight < x[i][0].to_i # No matter what order the arrays are in,
          tentativeDiscountWeight = x[i][0].to_i  # this will sort out the highest match.
          discountIndex = i # With this we can find which array contains the % we want.
        end
      else finalDiscountPercent = "0%"
      end
    @finalDiscountPercent = x[discountIndex][1]  # Percentage is the 2nd element in each array
    return @finalDiscountPercent # This returns a string
    end
  end
=end
=begin
  def calculate_subtotal_price(productTable)
    x = productTable
    subtotalPrice = 0
  # For each line in the table, subtotalPrice is sum of all the (quantity * price) amounts.
      for i in 0...x.count
      subtotalPrice += (x[i][1].to_i * x[i][5].to_f).round(2)
      end
    subtotalPrice
  end
=end
=begin
  def calculate_discount_price(discount_percent,subtotal_price)
    #First turn the discount percent from a string into a float. Then divide it by 100.
    percent = (discount_percent).to_f / 100
    # Finally the subtotal price is multiplied by percent to get the total price.
    discountPrice = subtotal_price * percent
    return discountPrice.round(2) # This returns a float rounded to 2 decimal places
  end
=end
=begin
  def calculate_total_price(subtotal_price,discount_price)
    totalPrice = subtotal_price - discount_price
  end    
=end
end