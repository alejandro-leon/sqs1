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
load "./users.rb"
# Another object is created here to manage users, this one is from the User class.
# The object internally loads a method to read user data from an external file.
fromUsers = User.new
# The file with the "Quote" class is loaded here, which contains the quoting methods.
load "./quotes.rb"
# Another object is created here.  This one is from the Quote class for creating quotes
fromQuotes = Quote.new
# The file with the "Utility" class is loaded here, which contains helper methods.
load "./utilities.rb"
# Another object is created here to manage quotes, this one is from the Quote class.
fromUtils = Utility.new
################################# User Authentication ###################################
# In this section the system starts the interaction with the user.
# A welcome screen is displayed at the start.
fromUtils.display_logo_banner(3)
# Below the welcome banner, the user is prompted for a username and a password.
# The credentials_valid? method is called to assign a true or false value to input.
# If input is "true" it is valid and the loop stops and lets the program continue.
# If input is invalid, it lets the user try again.
input = false
error =""
until input == true
  fromUtils.display_logo_banner(2)
  puts "#{error}Please enter your Username:"
  enterUsername = gets.chomp
  fromUtils.display_logo_banner(2)
  puts "Please enter your Password:"
  enterPassword = gets.chomp
  input = fromUsers.credentials_valid?(enterUsername,enterPassword)
  error = "Wrong credentials, try again. "
end
# Displays user's name according to successful login information
userName = fromUsers.get_full_name(enterUsername)
fromUtils.send_current_user(userName)
fromUtils.display_logo_banner(1)
puts "You have logged in successfully!"
#sleep 2.6
################################# newQuoteReport starts ####################################
##newQuoteReport = true
##While newQuoteReport == true


# User is prompted for the customer's information.
fromUtils.display_logo_banner(1)
puts "Provide your Customer's Full Name or Company Name:"
customerName = gets.chomp
# Creating a new array where this session quote lines will be stored for this customer.
#@quotes = []
################################## newQuoteLine starts ######################################
fromQuotes.create_new_quote(customerName)

################################### newQuoteLine ends #########################################
#end
################################### newQuoteReport ends #######################################

puts "done"
# A report is displayed with all the information the user entered.
system "exit"
