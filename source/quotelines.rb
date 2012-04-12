# The "QuoteLine" class contains methods which create the quote lines for the sales quote,
# combining user entered information for the device with information from the products file.
# When a new object from the "QuoteLine" class is created, the "Product" class is loaded as
# well as the "Utility" class which contain various required methods.
# The "Product" class loads the products from the products file.  This would resemble
# accessing a database to retrieve product information.  
# The "Utility" class provides the banners used throughout the menus.
# The products.rb file is loaded each time a new object of the QuoteLine class is created.
load "./products.rb"
require "./utilities" # Loads only if not loaded yet.

class QuoteLine

  # Method for creating new quote lines.  Used and called by the Quote class object with the 
  # create_new_quote method.
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
        fromUtils2.display_logo_banner(1) ; puts 
        puts "#{alert2}Please provide the name of the device to safeguard:"
        deviceName = gets.strip.chomp    #Blank spaces stripped at input.
        # Check device name is no longer than 14 characters and not blank.
        d = deviceName.length
        device = (d > 0) && (d < 15)
        if d == 0
          alert2 = "Invalid input. "
        else if d > 14
              alert2 = "14 character limit.  "
            end
        end
      end # until device
      # User is prompted for the number of similar devices requiring the same coverage.
      msg = "Quantity of \"#{deviceName}\" devices to safeguard under one product plan:"
      quantity = false
      until quantity == true
        fromUtils2.display_logo_banner(1) ; puts
        puts "#{msg}"
        deviceQuantity = gets.chomp
        deviceQuantity.slice!(",") # Remove any commas entered.
        # Check quantity is integer within defined range.  
        q = deviceQuantity.to_i
        quantity = (q > 0) && (q < 100000) # Range tested with Value equivalence analysis.
        msg = "\"#{deviceQuantity}\" Invalid input. Please enter a valid device quantity:"
      end
      # The product list is displayed through the display_product_list method and the user
      # is prompted to select a service product for the entered device(s).
      msg2 = "Select the ID of the product plan to safeguard the \"#{deviceName}\" device:"
      id = false
      until id == true
        fromProducts.display_product_list
        puts "#{msg2}"
        idNum = gets.chomp
        # Makes sure idNum is within range of products. 
        n = idNum.to_i  # The range below was tested with value equivalence analysis.
        id = (n >= 1) && (n <= fromProducts.get_product_count)
        msg2 = "\"#{idNum}\" is not a valid input, please enter a valid product ID:"
      end
      selectedProduct = fromProducts.match_product_id(idNum)
      # Take the device's name and quantity and create a new array along with the
      # selected product data producing a new quote line.
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
        self.display_quote_line(@quoteLines) ; puts
        puts "#{error1}#{error2}Which quote line would you like to delete?"
        lineID = gets.chomp
        error2 = ""
        #Check lineID is within range of products. 
        #Range tested with value equivalence analysis.
        n = lineID.to_i
        del2 = (n >= 1) && (n <= @quoteLines.length)
        error1 = "\"#{lineID}\" is not an option. "
      end # until del2
      self.display_quote_line(@quoteLines) ; puts
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
    puts "|     Device     |Quantity|      Product Plan      | Price/Unit|     Amount    |"
    puts "-"*80
    x = quoteTable # x is just a local variable to ease up typing
    for i in 0...x.count
      id = i.next; dv = x[i][0]; qt = x[i][1]; prod = x[i][2]; sla = x[i][3]; pu = x[i][5];
      plan = "#{prod},#{sla}";   dol1 = "$ "
      # Amount is quantity(converted to integer) x price/unit(converted to float).
      amount = qt.to_i * pu.to_f
      # Round amount to 2 decimal places, convert back to string, and add $ for print.
      am = "$ %6.2f"%amount
      puts "|#{id.to_s.ljust(2)}|#{dv.ljust(14)}|#{qt.center(6)}| #{plan.ljust(24)}|#{
      (dol1<<pu).rjust(10)} |#{am.rjust(14)} |"  
    end
    puts "-"*80
    puts; puts; puts "Hello, #{$userName}"; puts
  end

end # End QuoteLine class##########################
