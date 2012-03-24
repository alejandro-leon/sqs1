# The "User" class manages anything related to the users of the application.
class User

# Actions

  # Method that reads data from the users.txt file and creates a "table" with the user
  # information entered in the users.txt file by the manager or administrator.
  def initialize #load_user_list
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

  def get_user_table
    @user
  end
  
end