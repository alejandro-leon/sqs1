require "./users"
require "./utilities"
# This class basically contains methods to manage authentication into the system.
class Authentication

  def authenticate
    fromUtils = Utility.new
    # A welcome screen is displayed at the start.
    fromUtils.display_logo_banner(3)
    puts @user
    # Below the welcome banner, the user is prompted for a username and a password.
    # The credentials_valid? method is called to assign a true or false value to input.
    # If input is "true" it is valid and the loop stops and lets the program continue.
    # If input is invalid, it lets the user try again.
    input = false
    error =""
    until input == true
      fromUtils.display_logo_banner(2)
      puts "#{error}Please enter your Username:"
      @enterUsername = gets.chomp
      fromUtils.display_logo_banner(2)
      puts "Please enter your Password:"
      @enterPassword = gets.chomp
      input = self.credentials_valid?
      error = "Wrong credentials, try again. "
    end
  end
  
  # This method is a very basic authentication scheme where the entered username
  # and password are checked for a match. 
  # If the two strings match with a pair entered through the controller.user_list
  # method,a "true" value is returned, otherwise it returns "false".
  # Note that in the ideal case there would be a mechanism to encrypt and decrypt
  # the stored password so it cannot be read so easily.

  def credentials_valid?
    fromUsers = User.new
    u = fromUsers.get_user_table
    for i in 0...u.count
      validUsername = u[i][1]
      validPassword = u[i][2]
      value = (@enterUsername == validUsername) && (@enterPassword == validPassword)
      if value == true
        token = 1
      end
    end
    token == 1
  end

  # Method for identifying the name of the logged in user.
  def get_full_name
    fromUsers = User.new
    user = fromUsers.get_user_table
    for i in 0...user.count
        username = user[i][1] 
        if username == @enterUsername
          @currentUser = user[i][0]
        end
    end
    @currentUser
  end
  
end