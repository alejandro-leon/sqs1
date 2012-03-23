require "./products"
require "./utilities"
# This class will help in the business logic and display of quotes by the main application.
class Quote
# attr_accessor :quotes
# The "Quote" class contains methods which help create the quotes for the sales quote report,
# combining user entered information with information fetched from the product file.
# When a new object from the "Quote" class is created, the "Product" class is loaded as well 
# as a requirement, since it loads the products from the products file.  This would resemble
# accessing a database to retrieve product information.
  
  def mine
    fromUtils2 = Utility.new
    fromUtils2.line
  end
# Method for creating quotes
	def create_new_quote(customer)
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
    alert = ""
    until device == true
      fromUtils2.display_logo_banner(1)
      puts "#{alert}Provide the name of the device to safeguard:"
      deviceName = gets.strip.chomp    #Blank spaces stripped at input.
      # Check device name is no longer than 12 characters and not blank.
      d = deviceName.length
      device = (d > 0) && (d < 13)
      if d == 0
        alert = "Invalid input. "
      else if d > 13
            alert = "12 character limit.  "
          end
      end
    end
    # User is prompted for the number of similar devices requiring the same coverage.
    msg = "Provide the quantity of \"#{deviceName}\" devices to safeguard under one product plan:"
    quantity = false
    until quantity == true
      fromUtils2.display_logo_banner(1)
      puts "#{msg}"
      deviceQuantity = gets.chomp
      # Check quantity is integer within defined range. Tested with value equivalence analysis.
      q = deviceQuantity.to_i
      quantity = (q > 0) && (q < 1000000)
      msg = "\"#{deviceQuantity}\" is not a valid input, please enter a valid device quantity:"
    end
    # The product list is displayed through the display_product_list method and the user is 
    # prompted to select a service product for the entered device(s).
    msg2 = "Please select the ID of the product plan to safeguard the \"#{deviceName}\" device(s):"
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
    # Adds the new quote line array into the @quotes array
    @quotes << quoteline
    # Option selection for the quote line menu
    option = 2
    error2 = ""
    while option == 2
      self.display_quote_line(@quotes) # Displays the recent quote lines.
      puts "#{error2}Would you like to:"
      puts " (1) Add more devices              (2) Delete devices              (3) Continue "
      option = gets.to_i
      if (option > 0) and (option < 4)
        case option
        when 1
          newQuoteline = true
        when 2
          self.delete_quote_line
        when 3
          newQuoteLine = false
          selection = false
        end
      else
        error2 = "Invalid input.  "
        option = 2
      end
    end
  end
end

# This method has the function for deleting a quote line.#
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
      end
      self.display_quote_line(@quotes)
      puts "#{error2}Are you sure you want to delete \"#{lineID}\"?    1 (No)  2 (Yes)"
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
      end
    end  
  end ### Ends delete quote line.###
  
  #Method for calculating the discount. Compares total weight to weight from discount table.
  def calculate_total_discount
    x = @quotes
    totalWeight = 0
    for i in 0...x.count
      totalWeight += x[i][4]
    end
#need to calculate %
  end

  # Method for calculating the subtotal price of the selected products,
  # which is the total of product prices without the discount.
  def calculate_subtotal_price
    x = @quotes
    subtotalPrice = 0
  # For each line in the table do subtotalPrice is sum of all the (quantity * price).
      for i in 0...x.count
      subtotalPrice += (x[i][1].to_i * x[i][5].to_f).round(2)
      end
    subtotalPrice
  end

 #Forms
 
  #This method displays the newly added quote lines
  def display_quote_line(quoteTable)
    puts;puts;puts;puts;puts;puts;puts;puts;puts;puts;puts;puts;puts;puts
    puts "-"*80
    header = "Selections"
    puts "|#{header.center(78)}|"
    puts "-"*80
    puts "|     Device    |Quantity|       Product Plan        | Price/Unit|    Amount   |"
    puts "-"*80
    x = quoteTable # x is just a local variable to ease up typing
    for i in 0...x.count
      id = i.next; dv = x[i][0]; qt = x[i][1]; prod = x[i][2]; sla = x[i][3]; pu = x[i][5];
      plan = "#{prod},#{sla}";   dol1 = "$ "; dol2 = "$ "
      # Amount is quantity(converted to integer) x price/unit(converted to float).
      amount = qt.to_i * pu.to_f
      # Round amount to 2 decimal places, convert back to string, and add $ for print.
      am = dol2.concat(amount.round(2).to_s)
      puts "|#{id.to_s.rjust(2)}| #{dv.ljust(12)}|#{qt.center(6)}| #{plan.ljust(27)}|#{dol1.concat(pu).rjust(10)} |#{am.rjust(12)} |"
    end
    puts "-"*80
    puts; puts
  end


end
