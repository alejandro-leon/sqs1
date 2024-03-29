=begin
 Author: Alejandro León 

  This code is written in the Ruby programming language.  
 User Case story for this program:
  The following program is a prototype for the "Sales quoting system" and the target
 user is the salesperson.  When run, the program first reads an external file which 
 contains data about products
 (the products are the different service contracts to safeguard a customer's device).
 Each line read in the file is a product captured in the following format:"Option,
 Service Product, SLA, Weight, Price" (note: the weight is not the actual weight of the 
 product, but a number used to calculate possible discounts).  The file can be edited 
 by the user to change or add more items if needed before it is loaded into the system.
 At the command prompt, the user is asked to authenticate.  After successfully being
 identified by the system, the user is required to input the user's and the customer's 
 information first.  Then the system requests the user to input the customer's device's
 name  and the number of devices that fit this same description that the customer wishes
 to cover with the service product to be selected.  Immediately afterwards, a menu 
 with the various service products is displayed and the user has to select one of them
 for the described device(s).
 After all this input, the user is asked if another device needs to be added to the
 list.  If yes, the steps to add a device and its respective service product are
 repeated for the new one.  If not, the final report with all the information entered
 is displayed along with the total price (with discounts if applicable) of the
 selected products with their respective quantities.
 At the end, the user has the options of saving the newly created sales quote into a 
 file, discard the quote and create another new quote, or quit the application.
=end

# The application first loads the file containing the "Authentication" class which
# is a library of methods for authenticating the various users of the system.
require "./authentications.rb"
# The file with the "Quote" class is loaded here, which contains the quoting methods.
require "./quotes.rb"
# The file with the "Utility" class is loaded here, which contains helper methods.
require "./utilities.rb"
# An object is created here to manage users; it is from the Authentication class.
# This object uses a "User" class object as an interface to the users.txt file.
fromAuthentications = Authentication.new
# Another object is created here to display banners from the Utility class.
fromUtils = Utility.new

############################ User Authentication ###########################
# In this section the system starts the interaction with the user by calling the 
# authenticate method to get user information and validate it.
fromAuthentications.authenticate
# Displays user's name according to successful login information
$userName = fromAuthentications.get_full_name
fromUtils.display_logo_banner(1)
puts ""
puts "You have logged in successfully!"
sleep 2.6

########################### Quote Application starts #########################
# This is the main option selection menu for the sales Quote.
option1 = 1
error = ""
while option1 == 1
  fromUtils.display_logo_banner(1)
  puts "#{error}Would you like to:"
  puts " (1) Create new Quote           (2) Quit "
  option1 = gets.to_i # Gets user input
  if (option1 > 0) && (option1 < 3)
    case option1
    when 1
############################## new Quote starts #############################
      # A new object from the Quote class is created here. 
      # It then proceeds to open a module for creating quotes.
      newQuote = Quote.new
      newQuote.create_new_quote
############################## new Quote ends ##############################
    when 2
      option1 = 2
    end
  else
    error = "Invalid input.  "
    option1 = 1
  end # if
end # while option1 menu
############################ Quote Application ends ###########################
# Once the new object finishes executing, the system displays the last banner 
# and exits the application.
fromUtils.display_logo_banner(4)
system "exit"
############################## End of Application #############################