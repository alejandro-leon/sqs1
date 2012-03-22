# The "User" class manages anything related to the users of the application.
class User

# Actions

  # Method that reads data from the users.txt file and creates a "table" with the user
  # information entered in the users.txt file by the manager or administrator.
  def load_user_list
    # This specifies a file to be read for input data about users.
    usersFile = "./users.txt"    
    # Reads each line in the users.txt file and creates an array of strings in the instance
    # variable @user.
    @user = IO.readlines(usersFile)
    # Eliminates the file's header, which is the first line.
    @user.delete(@user[0])
    # Goes through each element of the user array and converts it from string to an array.
    # Basically creating arrays within an array.
    for i in 0...@user.count
      @user[i] = @user[i].chomp.split(/,/)
      # Strips (eliminates) any white spaces before and after each element in the new arrays,
      # just in case they were introduced in the users.txt file.
      for i2 in 0...@user[i].count
        @user[i][i2] = @user[i][i2].strip
      end
    end
  end

  # This method is a very basic authentication scheme where the entered username
  # and password are received as method arguments and checked for a match. 
  # If the two strings match with a pair entered through the controller.user_list
  # method,a "true" value is returned, otherwise it returns "false".
  # Note that in the ideal case there would be a mechanism to encrypt and decrypt
  # the stored password so it cannot be read so easily.
  def credentials_valid?(checkUser,checkPass)
    u = @user
    for i in 0...u.count
      validUsername = u[i][1]
      validPassword = u[i][2]
      value = (checkUser == validUsername) && (checkPass == validPassword)
      if value == true
        token = 1
      end
    end
    token == 1
  end

  # Method for identifying the name of the logged in user.
  def who_is_user?(logged_in_username)
    for i in 0...@user.count
        username = @user[i][1] 
        if username == logged_in_username
          @currentUser = @user[i][0]
        end
    end
    puts @currentUser
  end

#Forms

  # Method for displaying the banner
  def display_logo_banner(n)
    system "clear"
    puts; puts; puts
    puts"   SSSSSSSSSSSSSSS      QQQQQQQQQ        SSSSSSSSSSSSSSS ".center(80) 
    puts" SS:::::::::::::::S   QQ:::::::::QQ    SS:::::::::::::::S".center(80) 
    puts"S:::::SSSSSS::::::S QQ:::::::::::::QQ S:::::SSSSSS::::::S".center(80) 
    puts"S:::::S     SSSSSSSQ:::::::QQQ:::::::QS:::::S     SSSSSSS".center(80) 
    puts"S:::::S            Q::::::O   Q::::::QS:::::S            ".center(80)
    puts"S:::::S            Q:::::O     Q:::::QS:::::S            ".center(80)
    puts" S::::SSSS         Q:::::O     Q:::::Q S::::SSSS         ".center(80)
    puts"  SS::::::SSSSS    Q:::::O     Q:::::Q  SS::::::SSSSS    ".center(80)
    puts"    SSS::::::::SS  Q:::::O     Q:::::Q    SSS::::::::SS  ".center(80)
    puts"       SSSSSS::::S Q:::::O     Q:::::Q       SSSSSS::::S ".center(80)
    puts"            S:::::SQ:::::O  QQQQ:::::Q            S:::::S".center(80)
    puts"            S:::::SQ::::::O Q::::::::Q            S:::::S".center(80)
    puts"SSSSSSS     S:::::SQ:::::::QQ::::::::QSSSSSSS     S:::::S".center(80)
    puts"S::::::SSSSSS:::::S QQ::::::::::::::Q S::::::SSSSSS:::::S".center(80)
    puts"S:::::::::::::::SS    QQ:::::::::::Q  S:::::::::::::::SS ".center(80)
    puts" SSSSSSSSSSSSSSS        QQQQQQQQ::::QQ SSSSSSSSSSSSSSS   ".center(80)
    puts"                                QQQQQQQ                  ".center(80)
    case n
      when 1
    puts "Hello, #{@currentUser}"; puts ; puts
      when 2
    puts; puts; puts
      when 3
    puts"/ \\ / \\ / \\ /  \\ / \\ / \\ / \\     / \\ / \\       / \\ / \\ / \\    ".center(80) 
    puts"| W | E | L | C  | O | M | E |   | T | O |     | T | H | E |   ".center(80)
    puts" / \\ / \\ / \\ / \\ / \\  / \\ / \\ / \\ / \\ / \\ / \\ / \\   / \\ / \\ / \\ / \\ / \\ / \\".center(80)
    puts"| S | A | L | E | S || Q | U | O | T | I | N | G | | S | Y | S | T | E | M |".center(80)
    puts" \\ / \\ / \\ / \\ / \\ /  \\ / \\ / \\ / \\ / \\ / \\ / \\ /   \\ / \\ / \\ / \\ / \\ / \\ /".center(80)
    puts "Press \"Enter\" to start"; gets
    end
  end
end