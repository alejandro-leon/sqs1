# This class will help in the business logic and display of quotes by the main application.
class Quote
  def line
    @product
  end
  # Create a new array where the new quote lines will be stored
  @quotes = []

  # Method takes the device's name and quantity as arguments and creates a new array
  # along with the selected product data producing a new quote line.
  def create_quote_line (deviceName, deviceQuantity, selectedProduct)
    quoteline = [deviceName, deviceQuantity] + selectedProduct
    @quotes << quoteline
  end
  
  #Method for calculating the discount. Compares total weight to weight from discount table.
  def calculate_total_discount(quotesTable,discountTable)
    x = quotesTable
    totalWeight = 0
    for i in 0...x.count
      totalWeight += x[i][4]
    end
  end

  # Method for calculating the subtotal price of the selected products,
  # which is the total of product prices without the discount.
  def calculate_total_price(quotesTable)
    x = quotesTable
    subtotalPrice = 0
    for i in 0...x.count                              #for each line in the table do;
      subtotalPrice += (x[i][1].to_i * x[i][5].to_f)  #subtotalPrice sum of all the (quantity * price).
  end
  
 #Forms
 
  #This method displays the newly added quote lines
  def display_quote_line(quotesTable)
    puts;puts;puts;puts;puts;puts;puts;puts;puts;puts;puts
    puts "-"*80
    header = "Your Selections"
    puts "|#{header.center(78)}|"
    puts "-"*80
    puts "|     Device    |Quantity|       Product Plan        | Price/Unit|    Amount   |"
    puts "-"*80
    x = quotesTable # x is just a local variable to ease up typing
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
