# The "Quote" class contains methods that help create the new sales quote by
# combining user entered information with quote lines created by the QuoteLine class.
# The "Utility" class provides the banners used throughout some of the menus.
# The file discounts.rb is loaded each time a new object from the Quote class is created.
# The other two files are only loaded if not already loaded by another class.
load "./discounts.rb"
require "./utilities.rb"
require "./quotelines.rb"
class Quote

  # Method that calls the methods get_customer_name, get_business_opportunity,
  # display_sales_quote, all the calculation methods and also creates a new quote line
  # by creating an object from the QuoteLine class to create the final sales quote.
      
  def create_new_quote
    # Gets customer name
    @customerName = self.get_customer_name
    # Gets business opportunity
    @businessOpportunity = self.get_business_opportunity
    # New QuoteLine class object is created.
    fromQuoteLines = QuoteLine.new
    # The returned value is an array with device information and a selected product
    @quoteLines = fromQuoteLines.create_quote_line
    # Option selection menu for the sales quote taxing
    loop = true
    error = ""
    while loop == true
      fromQuoteLines.display_quote_line(@quoteLines) ; puts
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
    self.save_temp_quote # Saves a temp file with the data from the new Quote
    # This displays the preview of the final sales Quote 
    salesQuote = self.display_new_quote(@quoteLines,@customerName,@businessOpportunity,@tax)
    salesQuote # Displays the new sales quote.
    puts "Done! Press \"Enter\" for options."
    gets
    # Menu for saving the new quote.and gives the user the option to save the results into a file.
    loop = true
    error = ""
    message = ""
    fromUtils2 = Utility.new
    while loop == true # Loop for saving the file
      fromUtils2.display_logo_banner(1)
      puts "#{message}"
      puts "#{error}Would you like to:  (1) Save Quote    (2) Discard/Continue"
      option2 = gets.to_i
      if (option2 > 0) && (option2 < 3)
        case option2
        when 1
          returnValue = self.save_new_quote
          error = ""
        when 2
          File.delete("./temporary_internal_use.txt")
          loop = false
        end
      else
        error = "Invalid input. "
      end
      case returnValue # Case for selecting the save message to display.
      when 1
        message = "Save was successful!"
      when 2
        message = "Save was cancelled!"
      end
    end # while loop Menu, end save.
    return nil
  end # end create_new_quote
  
  # Method for getting the customer's name.
  def get_customer_name
    fromUtils2 = Utility.new
    customer = false
    alert = ""
    until customer == true
      fromUtils2.display_logo_banner(1) ; puts
      puts "#{alert}Please provide the customer's name:"
      customerName = gets.strip.chomp    #Blank spaces stripped at input.
      # Check customer name is no longer than 50 characters and not blank.
      c = customerName.length
      customer = (c > 0) && (c < 51) # Assigns boolean.
      if c == 0
        alert = "Invalid input. "
      else if c > 50
            alert = "50 character limit.  "
          end
      end # if d
    end  # until customer
    return customerName
  end # def
  # Method for getting the business opportunity information.
  def get_business_opportunity
    fromUtils2 = Utility.new
    business = false
    alert = ""
    until business == true
      fromUtils2.display_logo_banner(1) ; puts
      puts "#{alert}Provide a short description of this business opportunity:"
      businessOpportunity = gets.strip.chomp    #Blank spaces stripped at input.
      # Check customer name is no longer than 50 characters and not blank.
      c = businessOpportunity.length
      business = (c > 0) && (c < 51)
      if c == 0
        alert = "Invalid input. "
      else if c > 50
            alert = "50 character limit.  "
          end
      end # if d
    end  # until business
    return businessOpportunity
  end # def get_business_opportunity

# Calculations
# These group of methods get necessary values from the data entered by the user to 
# the @quoteLines array, which contains all the recently entered data arranged in arrays   
# of quote lines.  *These methods each do a calculation and return a specific value.

  # Method for calculating the total of all the quote line prices of the selected products,
  # which is the total of product prices without subtracting the discount.
  def calculate_lines_price
    x = @quoteLines
   linesPrice = 0
  # For each line in the table, linesPrice is sum of all the (quantity * price) amounts.
      for i in 0...x.count
      linesPrice += (x[i][1].to_i * x[i][5].to_f)
      end
    return linesPrice # Returns linesPrice as a float
  end
  # Method to help calculate the discount.  It checks if the total weight of the quote lines 
  # matches any of the thresholds and gets the specified discount percentage for the match.
  # First, find out the total weight of all the devices.
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
  # Then find out the discount for the resulting total weight.
  def calculate_discount_percent
    fromDiscounts = Discount.new
    w = self.calculate_total_weight # Total weight calculated before.
    x = fromDiscounts.get_discount_table  # This is the @discounts array
    tentativeDiscountWeight = 0
    for i in 0...x.count  # For each row in the discount table.
      if w >= x[i][0].to_i  # If total weight is greater or equal to the weight in that row.
        if tentativeDiscountWeight < x[i][0].to_i # No matter what order the arrays are in,
          tentativeDiscountWeight = x[i][0].to_i  # this will sort out the highest match.
          discountIndex = i # With this index we can find which array contains the % we want.
        end
      end
    end
    # If there are no matches, tentativeDiscount remains = 0 and no discount is given.
    if tentativeDiscountWeight == 0
      @finalDiscountPercent = "0%"
    else @finalDiscountPercent = x[discountIndex][1]  
    end # Above, the percentage is the 2nd element in each array.
    return @finalDiscountPercent # This returns a string
  end
  # After finding the percentage, percentage is converted to its currency value.
  def calculate_discount_price
    #First turn the discount percent from a string into a float. Then divide it by 100.
    percent = (self.calculate_discount_percent).to_f / 100
    # Finally the lines price is multiplied by percent to get the total price.
    discountPrice = self.calculate_lines_price * percent
    return discountPrice # This returns a float
  end
  # Later, the discount amount is subtracted from the lines price to get the subtotal.
  def calculate_subtotal_price
    subtotalPrice = self.calculate_lines_price - self.calculate_discount_price
    return subtotalPrice # Returns float
  end
  # Sales tax calculation method.  This tax is not included in the total price of the
  # calculate_total_price method because there are some customers which are from 
  # government or nonprofit institutions.
  def calculate_tax_price
    tax = 13 * self.calculate_subtotal_price / 100
    return tax # Returns float
  end
  # The total sales price is the subtotal price plus the sales tax price.
  def calculate_total_price
    total = self.calculate_subtotal_price + self.calculate_tax_price
  end

  # Method for displaying the final sales Quote with all the information specified by 
  # the user and the calculations for the total price.
  def display_new_quote(quoteLines,customerName,businessOpportunity,salesTax)
    puts;puts;puts;puts;puts;puts
    puts "-"*80; puts
    puts "MSA".ljust(80)
    puts "Sales Quote".center(80); puts
    puts "Date: #{Time.now.strftime("%d/%m/%Y")}".rjust(80)
    puts "Expiration Date: #{self.display_next_month}".rjust(80)
    puts "Salesperson: #{$userName}".rjust(80)
    puts "To: #{customerName}".ljust(80)
    puts "Business Opportunity: #{businessOpportunity}".ljust(80)
    puts; puts "-"*80
    puts "|    Device     |Quantity|      Product Plan       | Price/Unit|     Amount    |"
    puts "-"*80
    x = quoteLines # x is just a local variable to ease up typing
    for i in 0...x.count
      id = i.next; dv = x[i][0]; qt = x[i][1]; prod = x[i][2]; sla = x[i][3]; pu = x[i][5];
      plan = "#{prod},#{sla}";   dol = "$ "
      # Amount is quantity(converted to integer) x price/unit(converted to float).
      amount = qt.to_i * pu.to_f
      # Round amount to 2 decimal places, convert back to string, and add $ for print.
      am = "$ %6.2f"%amount
      puts "| #{dv.ljust(15)}|#{qt.center(6)}| #{plan.ljust(25)}|#{
      (dol<<pu).rjust(10)} |#{am.rjust(14)} |"
    end
    puts "|                |      |                          |           |               |"
    if self.calculate_discount_percent == "0%"
      puts "|                |      |                          |           |               |"
    else 
      di = self.calculate_discount_percent<<" discount"
      dp = self.calculate_discount_price
      puts "|                |      | #{di.center(25)}|           |#{
      ("-$ %6.2f"%dp.to_s).rjust(14)} |"
    end
    puts "-"*80 # This subtotal is actually named total price in the methods
    tp = self.calculate_subtotal_price
    puts "Subtotal |#{("$ %6.2f"%tp.to_s).rjust(14)} |".rjust(80) 
    case salesTax
    when 1
      st = self.calculate_tax_price
    when 2
      st = 0.00
    end
    puts "Sales Tax |#{("$ %6.2f"%st.to_s).rjust(14)} |".rjust(80)
    total = self.calculate_total_price
    puts "-----------------".rjust(80)
    puts "Total |#{("$ %6.2f"%total.to_s).rjust(14)} |".rjust(80)
    puts "-----------------".rjust(80)
  end

# Miscellaneous
  # Method for displaying the expiration date
  def display_next_month
    currentDate = Time.now.strftime("%d/%m/%Y")
    nextMonth = currentDate[3,2].succ
    if nextMonth == "13"
      nextMonth = "01"
    end
    nextDate = currentDate[0,3]<<nextMonth<<currentDate[5,5]
  end
  # Method that saves a temp file with the data from the new Quote
  def save_temp_quote
    newFile = "./temporary_internal_use.txt"
    output = File.open(newFile, "w")
    $stdout = output
    self.display_new_quote(@quoteLines,@customerName,@businessOpportunity,@tax)
    puts; puts; puts "Thank you for your business!".center(80)
    puts; puts; puts; puts "-"*80; puts; puts; puts
    output.close
    $stdout = STDOUT
  end
  # Method that prompts the user to save the newly created sales Quote to a file.
  def save_new_quote
    fromUtils2 = Utility.new
    loop = true
    error = ""
    while loop == true
      fromUtils2.display_logo_banner(1) ; puts
      puts"#{error}Enter name of new file to save:"
      newFileName = gets.chomp
      newFileName = newFileName.partition(".")
      newFileName = newFileName[0]<<".txt"
      if File::file?("./#{newFileName}") == true  # Verify if file already exits.
        fromUtils2.display_logo_banner(1)
        error = ""
        puts "Replace the file \"#{newFileName}\" in the destination directory?" 
        puts " (1) Replace          (2) Cancel     "
        option = gets.to_i
          if (option > 0) && (option < 3)
            case option
            when 1 # Copy all data from temp file to new file.
              File.open("./#{newFileName}","w") do |newfile|
                File.open("./temporary_internal_use.txt","r") do |tempfile|
                  while line = tempfile.gets
                    newfile.puts line
                  end
                end
              end
              returnValue = 1
              loop = false
            when 2
              returnValue = 2
              loop = false
            end
          else
            error = "Invalid input. "
          end # if (option)
      else 
          File.open("./#{newFileName}","w") do |newfile|
            File.open("./temporary_internal_use.txt","r") do |tempfile|
              while line = tempfile.gets
                newfile.puts line
              end
            end
          end
          returnValue = 1
          loop = false
      end # if File
    end # while loop
    return returnValue
  end # Save new quote ends
  
end # End Quote class##########################
