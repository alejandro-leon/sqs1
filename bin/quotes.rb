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

#Actions
  # Method for creating a new Quote Report
  def initialize # Main method in "Quote" class.
    fromUtils2 = Utility.new
    newQuote = true
    while newQuote == true
      # Option selection  menu for the Quote Report
      option1 = 1
      error = ""
      while option1 == 1
        fromUtils2.display_logo_banner(1)
        puts "#{error}Would you like to:"
        puts " (1) Create new Quote           (2) Quit "
        option1 = gets.to_i
        if (option1 > 0) && (option1 < 3)
          case option1
          when 1
            self.create_new_quote # Calls in class method for creating a new Quote.
            # Menu for saving new quote report. This displays the final sales Quote and gives 
            # the user the option to save the results into a file.
            loop = true
            error = ""
            until loop == false
              $salesQuote # Displays the new sales quote.
              puts "#{error}Would you like to:  (1) Save Quote     (2) Discard"
              option2 = gets.to_i
              if (option2 > 0) && (option2 < 3)
                case option2
                when 1
                  returnValue = self.save_new_quote
                  if returnValue == true
                    loop = false
                    error = ""
                  else
                    loop = true
                    error = ""
                  end
                when 2
                  loop = false
                end
              else
                error = "Invalid input. "
                loop = true
              end
            end # while loop Menu
            newQuote = true
          when 2
            newQuote = false
            option1 = 2
          end
        else
          error = "Invalid input.  "
          option1 = 1
        end # if
      end # while option1 menu
    end # while newQuote

  end # End newQuote
  # Method that calls the methods get_customer_name, get_business_opportunity,
  # create_quote_line, display_sales_quote,and all the calculation methods to
  # create the final sales quote.
  def create_new_quote
    @customerName = self.get_customer_name
    @businessOpportunity = self.get_business_opportunity
    @quoteLines = self.create_quote_line
    # Option selection  menu for the sales Quote
    loop = true
    error = ""
    while loop == true
      self.display_quote_line(@quoteLines)
      puts "#{error}Apply sales tax?       (1) Tax      (2) No Tax"
      option = gets.to_i
      if (option > 0) && (option < 3)
        case option
        when 1
          loop = false
          @tax = 1
        when 2
          loop = false
          @tax = 2
        end
      else
        error = "Invalid input.  "
        loop = true
      end
    end
    $salesQuote = self.display_new_quote(@quoteLines,@customerName,@businessOpportunity,@tax)
    return $salesQuote # Returns the complete Quote with all the information formatted.
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
      customer = (c > 0) && (c < 51) # Asigns boolean.
      if c == 0
        alert = "Invalid input. "
      else if c > 50
            alert = "50 character limit.  "
          end
      end # if d
    end  # until customer
    return customerName
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
    return businessOpportunity
  end # def get_business_opportunity

  # Quote line methods.#
  # Method for creating new quote lines.
  def create_quote_line
    # A new object is created called "fromProducts" from the "Product" class.
    fromProducts = Product.new
    # Then a new object is created called "fromUtils" from the "Utility" class.
    fromUtils2 = Utility.new
    # Create a new array where this session quote lines will be stored for the customer
    @quoteLines = []
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
      # Adds the new quote line array as a new element of the @quoteLines array.
      quoteTable = @quoteLines << quoteline
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
    return @quoteLines
  end # def create_quote_line #
  # This method is used for deleting a quote line.
  def delete_quote_line
    error2 = ""
    del = false
    until del == true
      error1 = ""
      del2 = false
      until del2 == true   
        self.display_quote_line(@quoteLines)
        puts "#{error1}#{error2}Which quote line would you like to delete?"
        lineID = gets.chomp
        #Check lineID is within range of products. 
        #Range tested with value equivalence analysis.
        n = lineID.to_i
        del2 = (n >= 1) && (n <= @quoteLines.length)
        error1 = "\"#{lineID}\" is not an option.  "
      end # until del2
      self.display_quote_line(@quoteLines)
      puts "#{error2}Are you sure you want to delete line \"#{lineID}\"?    1 (No)  2 (Yes)"
      sure = gets.to_i
      if (sure > 0) and (sure < 3)
        case sure
          when 2
            n = lineID.to_i - 1
            @quoteLines.delete(@quoteLines[n])
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
  # This method displays the newly added quote lines on the screen.
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
      plan = "#{prod},#{sla}";   dol1 = "$ "
      # Amount is quantity(converted to integer) x price/unit(converted to float).
      amount = qt.to_i * pu.to_f
      # Round amount to 2 decimal places, convert back to string, and add $ for print.
      am = "$ %6.2f"%amount
      puts "|#{id.to_s.rjust(2)}| #{dv.ljust(12)}|#{qt.center(6)}| #{plan.ljust(25)}|#{(dol1<<pu).rjust(10)} |#{am.rjust(14)} |"  
    end
    puts "-"*80
    puts; puts "Hello, #{$userName}"; puts ; puts
  end

# Calculations
# These group of methods get necessary values from the data entered by the user to 
# the @quoteLines array, which contains all the recently entered data arranged in arrays   
# of quote lines.  *These methods do a calculation and return a specific value.

  # Method for calculating the subtotal price of the selected products,
  # which is the total of product prices without subtracting the discount.
  def calculate_subtotal_price
    x = @quoteLines
    subtotalPrice = 0
  # For each line in the table, subtotalPrice is sum of all the (quantity * price) amounts.
      for i in 0...x.count
      subtotalPrice += (x[i][1].to_i * x[i][5].to_f)#.round(2)
      end
    return subtotalPrice # Returns subtotalPrice as a float
  end
  # Method to help calculate the discount.  It checks if the total weight of the quote lines 
  # matches any of the thresholds and gets the specified discount percentage for the match.
  # First we find out the total weight of all the devices.
  def calculate_total_weight
    x = @quoteLines
    totalWeight = 0
    for i in 0...x.count
      # Multiply the 5th element (weight) to the 2nd element (quantity) to get the total
      # of each quote line in the array and add them together one by one.
      totalWeight += (x[i][4].to_i * x[i][1].to_i)
    end
    return totalWeight # This returns an integer
  end
  # Then find out the discount to the resulting total weight.
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
  # # After finding the percentage, percentage is converted to its currency value.
  def calculate_discount_price
    #First turn the discount percent from a string into a float. Then divide it by 100.
    percent = (self.calculate_discount_percent).to_f / 100
    # Finally the subtotal price is multiplied by percent to get the total price.
    discountPrice = self.calculate_subtotal_price * percent
    return discountPrice.round(2) # This returns a float
  end
  # Later, the discount amount is subtracted from the subtotal price to get the total.
  def calculate_total_price
    totalPrice = self.calculate_subtotal_price - self.calculate_discount_price
    return totalPrice # Returns float
  end
  # Sales tax calculation method.  This tax is not included in the total price of the
  # calculate_total_price method because there are some customers which are from 
  # government or nonprofit institutions.
  def calculate_tax_price
    tax = 13 * self.calculate_total_price / 100
    return tax # Returns float
  end
  
# New Quote methods
  #Method for displaying the final sales Quote with all the information specified by the user
  #and the calculations for the total price.
  def display_new_quote(quoteLines,customerName,businessOpportunity,salesTax)
        puts;puts;puts;puts;puts;puts
        puts "-"*80
        puts
        puts "MSA".ljust(80)
        puts "Sales Quote".center(80)
        puts
        puts "Date: #{Time.now.strftime("%d/%m/%Y")}".rjust(80)
        puts "Expiration Date: #{self.display_next_month}".rjust(80)
        puts "Salesperson: #{$userName}".rjust(80)
        puts "To: #{customerName}".ljust(80)
        puts "Business Opportunity: #{businessOpportunity}".ljust(80)
        puts
        puts "-"*80
        puts "|    Device   |Quantity|        Product Plan       | Price/Unit|     Amount    |"
        puts "-"*80
        x = quoteLines # x is just a local variable to ease up typing
        for i in 0...x.count
          id = i.next; dv = x[i][0]; qt = x[i][1]; prod = x[i][2]; sla = x[i][3]; pu = x[i][5];
          plan = "#{prod},#{sla}";   dol = "$ "
          # Amount is quantity(converted to integer) x price/unit(converted to float).
          amount = qt.to_i * pu.to_f
          # Round amount to 2 decimal places, convert back to string, and add $ for print.
          am = "$ %6.2f"%amount
          puts "| #{dv.ljust(13)}|#{qt.center(6)}| #{plan.ljust(27)}|#{(dol<<pu).rjust(10)} |#{am.rjust(14)} |"
        end
        puts "|              |      |                            |           |               |"
        if self.calculate_discount_percent == "0%"
          puts "|              |      |                            |           |               |"
        else 
          di = self.calculate_discount_percent<<" discount"
          dp = self.calculate_discount_price
          puts "|              |      | #{di.center(27)}|           |#{("-$ "<<dp.to_s).rjust(14)} |"
        end
        puts "-"*80
        tp = self.calculate_total_price
        puts "Subtotal |#{("$ %6.2f"%tp.to_s).rjust(14)} |".rjust(80) # this is actually the total price in the methods
        case salesTax
        when 1
          st = self.calculate_tax_price
        when 2
          st = 0.00
        end
        puts "Sales Tax |#{("$ %6.2f"%st.to_s).rjust(14)} |".rjust(80)
        total = tp + st; 
        puts "-----------------".rjust(80)
        puts "Total |#{("$ %6.2f"%total.to_s).rjust(14)} |".rjust(80)
        puts "-----------------".rjust(80)
  end

# Miscellaneous
  def display_next_month
    currentDate = Time.now.strftime("%d/%m/%Y")
    nextMonth = currentDate[3,2].succ
    if nextMonth == "13"
      nextMonth = "01"
    end
    nextDate = currentDate[0,3]<<nextMonth<<currentDate[5,5]
  end
    # Section that prompts the user to save the newly created sales Quote to a file.
  def save_new_quote
    fromUtils2 = Utility.new
    loop = true
    while loop == true
      fromUtils2.display_logo_banner(1)
      puts"Save the new Quote as:"
      newFile = gets.chomp
      newFile = newFile.partition(".")
      newFile = newFile[0]<<".txt"
      fromUtils2.display_logo_banner(1)
      error = ""
      puts "#{error}Will replace any file named \"#{newFile}\" in the destination directory!" 
      puts " (1) Replace          (2) Cancel     "
      option = gets.to_i
      if (option > 0) && (option < 3)
        case option
        when 1
          loop = false
          File.open(newFile,"w") do |f|
          f.write $salesQuote
          fromUtils2.display_logo_banner(1)
          puts "Save was successful !"
          sleep 2
          returnValue = true
          end
        when 2
          loop = false
          fromUtils2.display_logo_banner(1)
          puts "Save was cancelled!"
          returnValue = false
          sleep 2
        end
      else
        error = "Invalid input. "
        loop = true
      end
    end
    return returnValue
  end # Save new quote ends
end # End class
