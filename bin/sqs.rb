#Author: Alejandro León 
#
# This code is written in the Ruby programming language.  
# User Case story for this program:
# The resulting program is a prototype for the "Sales quoting system" and the target
# user is the salesperson.
# When run, the program first reads an external file which contains data about products
# (the products are the different service contracts to safeguard a customer's device).
# Each line read in the file is a product captured in the following format:"Option,
# Service Product, SLA, Weight, Price" (note: the weight is not the actual weight of the 
# product, but a number used to calculate possible discounts).  The file can be edited 
# by the user to change or add more items if needed before it is loaded into the system.
# At the command prompt, the user is asked to authenticate.  After successfully being
# identified by the system, the user is required to input the user's and the customer's 
# information first.  Then the system requests the user to input the customer's device's
# name  and the number of devices that fit this same description that the customer wishes
# to cover with the service product to be selected.  Immediately afterwards, a menu 
# with the various service products is displayed and the user has to select one of them
# for the described device(s).
# After all this input, the user is asked if she/he wants to add another device to the
# list.  If yes, the steps to add a device and its repective service product are
# repeated for the new one.  If not, the final report with all the information entered
# is displayed along with the total price (with discounts if applicable) of the
# selected products with their repective quantities.

# Here, the program loads the class "Control" which is a library containing the methods
# to produce different actions and display various forms.
load "./products.rb"
# A new object is created called "fromProducts" from the Product class
fromProducts = Product.new
# The object calls the load_product_list method to read product data from external file
fromProducts.load_product_list
# The file with the "User" class is loaded here, which contains user related methods.
load "./users.rb"
# Another object is created here to manage users, this one is from the User class.
fromUsers = User.new
# The object calls the load_user_list method to read user data from external file
fromUsers.load_user_list
# The file with the "Quote" class is loaded here, which contains quoting helper methods.
load "./quotes.rb"
# Another object is created here to manage quotes, this one is from the Quotes class.
fromQuotes = Quote.new
################################## User Authentication ####################################
# In this section the system starts the interaction with the user.
# A welcome screen is displayed at the start.
fromUsers.display_logo_banner(3)
# Below the welcome banner, the user is prompted for a username and a password.
# The authentication_valid? method is called to assign a true or false value to input.
# If input is "true" it is valid and the loop stops and lets the program continue.
# If input is invalid, it lets the user try the remaining number of attempts.
# The number of attempts is counted by "i"; when it passess 5 loops, the program exits.
input = false
error =""
until input == true
  fromUsers.display_logo_banner(2)
  puts "#{error}Please enter your Username:"
  checkUsername = gets.chomp
  fromUsers.display_logo_banner(2)
  puts "Please enter your Password:"
  checkPassword = gets.chomp
  input = fromUsers.credentials_valid?(checkUsername,checkPassword)
  error = "Wrong credentials, try again. "
end
# Displays user's name according to successful login information
userName = fromUsers.who_is_user?(checkUsername)
fromUsers.display_logo_banner(1)
puts "You have logged in successfully!"
#sleep 2.6
################################# newQuoteReport starts ####################################
##newQuoteReport = true
##While newQuoteReport == true


# User is prompted for the customer's information.
fromUsers.display_logo_banner(1)
puts "Provide your Customer's Full Name or Company Name:"
customerName = gets.chomp
# Creating a new array where this session quote lines will be stored for this customer.
@quotes = []
################################## newQuoteLine starts ######################################
newQuoteLine = true
while newQuoteLine == true
  # User is prompted for a description of the device for coverage.
  device = false
  until device == true
    fromUsers.display_logo_banner(1)
    puts "#{alert}Provide the name of the device to safeguard:"
    deviceName = gets.strip.chomp
    # Check device name is no longer than 12 characters and not blank
    d = deviceName.length
    device = (d > 0) && (d < 13)
    alert = "Name invalid. "
  end
  # User is prompted for the number of similar devices requiring the same coverage.
  msg = "Provide the quantity of \"#{deviceName}\" devices to safeguard under one product plan:"
  quantity = false
  until quantity == true
    fromUsers.display_logo_banner(1)
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
  # Quotes created with the information given.  Take the device's name and quantity
  # and create a new array along with the selected product data producing a new quote line.
  quoteline =  [deviceName, deviceQuantity] + selectedProduct
  # Adds the new quote line array into the @quotes array
  @quotes << quoteline
  # For displaying the quote line
  displayQL = fromQuotes.display_quote_line(@quotes) 
  # Option selection for the quote line menu
  option = 2
  error2 = ""
  while option == 2
    # For displaying the quote line
    fromQuotes.display_quote_line(@quotes)
    puts "#{error2}Would you like to:"
    puts " (1) Add more devices              (2) Delete devices              (3) Continue "
    option = gets.to_i
    if (option > 0) and (option < 4)
      case option
      when 1
        newQuoteline = true
      when 2
        ### This section has the function to delete a quote line.###
        error2 = ""
        del = false
        until del == true
          error1 = ""
          del2 = false
          until del2 == true   
            fromQuotes.display_quote_line(@quotes)
            puts "#{error1}#{error2}Which quote line would you like to delete?"
            lineID = gets.chomp
            #Check lineID is within range of products. Range tested with value equivalence analysis.
            n = lineID.to_i
            del2 = (n >= 1) && (n <= @quotes.length)
            error1 = "\"#{lineID}\" is not an option.  "
          end
          fromQuotes.display_quote_line(@quotes)
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
        end   ### Ends delete quote line.###
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
################################### newQuoteLine ends #########################################
#end
################################### newQuoteReport ends #######################################

puts "done"
# A report is displayed with all the information the user entered.
system "exit"
