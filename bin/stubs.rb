require "./discounts"
class Quote2

  def calculate_total_discount(t)
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
    return @finalDiscountPercent
    end
  end
  
end