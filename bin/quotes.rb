require "./products"
require "./discounts"
require "./utilities"
# This class will help in the business logic and display of quotes by the main application.
class Quote

# The "Quote" class contains methods which help create the quotes for the sales quote report,
# combining user entered information with information fetched from the product file.
# When a new object from the "Quote" class is created, the "Product" class is loaded as well 
# as a requirement, since it loads the products from the products file.  This would resemble
# accessing a database to retrieve product information.

  # Method for creating a new Quote Report
  def initialize #create_quote_report # Main method in "Quote" class.
    fromUtils2 = Utility.new    
    newQuoteReport = true
    while newQuoteReport == true
       # Option selection  menu for the Quote Report
      option1 = 1
      error3 = ""
      while option1 == 1
        fromUtils2.display_logo_banner(1)
        puts "#{error3}Would you like to:"
        puts " (1) Create new Quote          (2) Quit "
        option1 = gets.to_i
        if (option1 > 0) and (option1 < 3)
          case option1
          when 1
            # Here it starts to call other methods in the same "Quote" class.
            customerName = self.get_customer_name
            businessOpportunity = self.get_business_opportunity
            quoteLines = self.create_quote_line
            newQuoteReport = true
          when 2
            newQuoteReport = false
            option1 = 2
          end
        else
          error3 = "Invalid input.  "
          option1 = 1
        end # if
      end # while option1 menu
    end # while newQuoteReport
    
    puts customerName
    puts businessOpportunity
    puts quoteLines
  end # End new Quote Report   
    
    # Method for creating new quote lines #
  def create_quote_line
      # A new object is created called "fromProducts" from the "Product" class.
      fromProducts = Product.new
      # Then a new object is created called "fromUtils" from the "Utility" class.
      fromUtils2 = Utility.new
      # Create a new array where this session quote lines will be stored for the customer
      @quotes = []
      # New quote lines are created here
      newQuoteLine = true
      while newQuoteLine == true
        # User is prompted for a description of the device for coverage.
        device = false
        alert2 = ""
        until device == true
          fromUtils2.display_logo_banner(1) 
          puts "#{alert2}Please provide the name of the device to safeguard:"
          deviceName = gets.strip.chomp    #Blank spaces stripped at input.
          # Check device name is no longer than 12 characters and not blank.
          d = deviceName.length
          device = (d > 0) && (d < 13)
          if d == 0
            alert2 = "Invalid input. "
          else if d > 13
                alert2 = "12 character limit.  "
              end
          end
        end # until device
        # User is prompted for the number of similar devices requiring the same coverage.
        msg = "Provide the quantity of \"#{deviceName}\" devices to safeguard under one product plan:"
        quantity = false
        until quantity == true
          fromUtils2.display_logo_banner(1) 
          puts "#{msg}"
          deviceQuantity = gets.chomp
          deviceQuantity.slice!(",") # Remove any commas entered.
          # Check quantity is integer within defined range. Tested with value equivalence analysis.
          q = deviceQuantity.to_i
          quantity = (q > 0) && (q < 100000)
          msg = "\"#{deviceQuantity}\" 99,999 limit, please enter a valid device quantity:"
        end
        # The product list is displayed through the display_product_list method and the user is 
        # prompted to select a service product for the entered device(s).
        msg2 = "Please select the ID of the product plan to safeguard the \"#{deviceName}\" device:"
        id = false
        until id == true
          fromProducts.display_product_list
          puts "#{msg2}"
          idNum = gets.chomp
          #Makes sure idNum is within range of products. Range tested with value equivalence analysis.
          n = idNum.to_i
          id = (n >= 1) && (n <= fromProducts.get_product_count)
          msg2 = "\"#{idNum}\" is not a valid input, please enter a valid product ID:"
        end
        selectedProduct = fromProducts.match_product_id(idNum)
        # Take the device's name and quantity and create a new array along with the selected product
        # data producing a new quote line.
        quoteline =  [deviceName, deviceQuantity] + selectedProduct
        # Adds the new quote line array as a new element of the @quotes array.
        quoteTable = @quotes << quoteline
        # Option selection for the quote line menu.
        option = 2
        error2 = ""
        while option == 2
          self.display_quote_line(quoteTable) # Displays the recent quote lines.
          puts "#{error2}Would you like to:"
          puts " (1) Add more devices              (2) Delete devices              (3) Continue "
          option = gets.to_i
          if (option > 0) and (option < 4)
            case option
            when 1
              newQuoteLine = true
            when 2
              self.delete_quote_line # Calls method to delete quote line.
            when 3
              newQuoteLine = false
            end
          else
            error2 = "Invalid input.  "
            option = 2
          end # if option
        end # while option
      end # while newQuoteLine
      return @quotes
  end # def create_quote_line #
  # This method is used for deleting a quote line.#
  def delete_quote_line
        error2 = ""
        del = false
        until del == true
          error1 = ""
          del2 = false
          until del2 == true   
            self.display_quote_line(@quotes)
            puts "#{error1}#{error2}Which quote line would you like to delete?"
            lineID = gets.chomp
            #Check lineID is within range of products. 
            #Range tested with value equivalence analysis.
            n = lineID.to_i
            del2 = (n >= 1) && (n <= @quotes.length)
            error1 = "\"#{lineID}\" is not an option.  "
          end # until del2
          self.display_quote_line(@quotes)
          puts "#{error2}Are you sure you want to delete line \"#{lineID}\"?    1 (No)  2 (Yes)"
          sure = gets.to_i
          if (sure > 0) and (sure < 3)
            case sure
              when 2
                n = lineID.to_i - 1
                @quotes.delete(@quotes[n])
                del = true
              when 1
                del = true
            end 
          else
            error2 = "Invalid input. "
            del = false
          end # if sure
        end  # until del
      end # def delete_quote_line
  #This method displays the newly added quote lines.
  def display_quote_line(quoteTable)
        puts;puts;puts;puts;puts;puts;puts;puts;puts;puts;puts;puts;puts;puts
        puts "-"*80
        header = "Selections"
        puts "|#{header.center(78)}|"
        puts "-"*80
        puts "|    Device     |Quantity|       Product Plan      | Price/Unit|     Amount    |"
        puts "-"*80
        x = quoteTable # x is just a local variable to ease up typing
        for i in 0...x.count
          id = i.next; dv = x[i][0]; qt = x[i][1]; prod = x[i][2]; sla = x[i][3]; pu = x[i][5];
          plan = "#{prod},#{sla}";   dol1 = "$ "; dol2 = "$ "
          # Amount is quantity(converted to integer) x price/unit(converted to float).
          amount = qt.to_i * pu.to_f
          # Round amount to 2 decimal places, convert back to string, and add $ for print.
          am = dol2 << amount.round(2).to_s
          puts "|#{id.to_s.rjust(2)}| #{dv.ljust(12)}|#{qt.center(6)}| #{plan.ljust(25)}|#{(dol1<<pu).rjust(10)} |#{am.rjust(14)} |"  
        end
        puts "-"*80
        puts; puts "Hello, #{$userName}"; puts ; puts
      end

  # Method for getting the customer's name.
  def get_customer_name
    fromUtils2 = Utility.new
    customer = false
    alert = ""
    until customer == true
      fromUtils2.display_logo_banner(1)
      puts "#{alert}Please provide the customer's name:"
      customerName = gets.strip.chomp    #Blank spaces stripped at input.
      # Check customer name is no longer than 50 characters and not blank.
      c = customerName.length
      customer = (c > 0) && (c < 51)
      if c == 0
        alert = "Invalid input. "
      else if c > 51
            alert = "50 character limit.  "
          end
      end # if d
    end  # until customer
  end # def get_customer_name
  # Method for getting the business opportunity information.
  def get_business_opportunity
    fromUtils2 = Utility.new
    business = false
    alert = ""
    until business == true
      fromUtils2.display_logo_banner(1)
      puts "#{alert}Provide a short description of this business opportunity:"
      businessOpportunity = gets.strip.chomp    #Blank spaces stripped at input.
      # Check customer name is no longer than 50 characters and not blank.
      c = businessOpportunity.length
      business = (c > 0) && (c < 51)
      if c == 0
        alert = "Invalid input. "
      else if c > 51
            alert = "50 character limit.  "
          end
      end # if d
    end  # until business
  end # def get_business_opportunity

# Calculations
  # These group of methods get necessary values from the data entered by the user to 
  # the @quotes array, which contains all the recently entered data arranged in arrays   
  # of quote lines.

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
      # Multiply the 5th element (weight) to the 2nd element (quantity) to get the total
      # of each quote line and then add them together.
      totalWeight += (x[i][4].to_i * x[i][1].to_i)
    end
    return totalWeight # This returns an integer
  end
  # Then we find out the discount to the resulting total weight.
  def calculate_discount_percent
    fromDiscounts = Discount.new
    w = self.calculate_total_weight
    x = fromDiscounts.get_discount_table  # This is the @discounts array
    tentativeDiscountWeight = 0
    for i in 0...x.count
      if w >= x[i][0].to_i
        if tentativeDiscountWeight < x[i][0].to_i # No matter what order the arrays are in,
          tentativeDiscountWeight = x[i][0].to_i  # this will sort out the highest match.
          discountIndex = i # With this index we can find which array contains the % we want.
        end
      end
    end
    # If there are no matches, tentativeDiscount remains = 0 and no discount is given.
    if tentativeDiscountWeight == 0
      @finalDiscountPercent = "0%"
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

=begin
# Calculations
  # Method for calculating the subtotal price of the selected products,
  # which is the total of product prices without subtracting the discount.
  def calculate_subtotal_price
    x = @quotes
    subtotalPrice = 0
  # For each line in the table, subtotalPrice is sum of all the (quantity * price) amounts.
      for i in 0...x.count
      subtotalPrice += (x[i][1].to_i * x[i][5].to_f).round(2)
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
  def calculate_discount_percent
    fromDiscounts = Discount.new
    t = self.calculate_total_weight
    x = fromDiscounts.get_discount_table  # This is the discounts array
    tentativeDiscountWeight = 0
    for i in 0...x.count
      if t >= x[i][0].to_i
        if tentativeDiscountWeight < x[i][0].to_i # No matter what order the arrays are in,
          tentativeDiscountWeight = x[i][0].to_i  # this will sort out the highest match.
          discountIndex = i # With this index we can find which array contains the % we want.
        end
      else finalDiscountPercent = "0%"
      end
    @finalDiscountPercent = x[discountIndex][1]  # Percentage is the 2nd element in each array
    return @finalDiscountPercent # This returns a string
    end
  end
  # After knowing the percentage, we can figure out what percentage that percentage is
  # in dollar amount.
  def calculate_discount_price
    #First turn the discount percent from a string into a float. Then divide it by 100.
    percent = (self.calculate_discount_percent).to_f / 100
    # Finally the subtotal price is multiplied by percent to get the total price.
    discountPrice = self.calculate_subtotal_price * percent
    return discountPrice.round(2) # This returns a float rounded to 2 decimal places
  end
  # Finally, we subtract the discount amount from the subtotal price to get the final price.
  def calculate_total_price
    totalPrice = self.calculate_subtotal_price - self.calculate_discount_price
  end    
=end

end
