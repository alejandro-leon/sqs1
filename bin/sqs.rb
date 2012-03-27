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
 list.  If yes, the steps to add a device and its repective service product are
 repeated for the new one.  If not, the final report with all the information entered
 is displayed along with the total price (with discounts if applicable) of the
 selected products with their repective quantities.
=end
# Here, the program loads the file containing the class "Users" which is a library 
# of methods for authenticating the various users of the system.
load "./authentications.rb"
# Another object is created here to manage users; it is from the Authentication class.
# This object uses a "User" class object as an interface to the users.txt file.
fromAuthentications = Authentication.new
# The file with the "Quote" class is loaded here, which contains the quoting methods.
load "./quotes.rb"
# The file with the "Utility" class is loaded here, which contains helper methods.
load "./utilities.rb"
# Another object is created here to manage quotes, this one is from the Quote class.
fromUtils = Utility.new
################################# User Authentication ###################################
# In this section the system starts the interaction with the user by calling the 
# authenticate method to get user information and validate it.
fromAuthentications.authenticate
# Displays user's name according to successful login information
$userName = fromAuthentications.get_full_name
#fromUtils.send_current_user(@userName)
fromUtils.display_logo_banner(1)
puts "You have logged in successfully!"
sleep 2.6
################################# newQuoteReport starts ####################################
# A new object from the Quote class is created here and opens a module for creating quotes.
startQuoting = Quote.new

################################### newQuoteReport ends #######################################
fromUtils.display_logo_banner(4)
system "exit"
