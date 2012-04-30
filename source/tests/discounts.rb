# Discount is the class that provides the interface to the discount information by 
# accessing the discounts data file.
class Discount
  # Method that retrieves the discount information from the discounts.txt file
  def initialize #load_discount_list
  discountsFile = "./data/discounts.txt" # access the external file
  @discount = IO.readlines(discountsFile) # reads each line and saves them into an array
  @discount.delete(@discount[0]) # eliminates the first two lines which are comments.
  @discount.delete(@discount[0])
  # Goes through each element of the @discount array and convert it from string to an array.
    for i in 0...@discount.count
      @discount[i] = @discount[i].chomp.split(/,/)
      # Strips (eliminates) any white spaces before and after each element in the new arrays.
      for i2 in 0...@discount[i].count
        @discount[i][i2] = @discount[i][i2].strip
      end # for i2
    end # for i
  end # def

  # Method for accessing the discount table created from the discount.txt file.
  def get_discount_table
    @discount
  end
  
end