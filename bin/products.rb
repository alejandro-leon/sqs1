# This Class contains the methods to control the different actions and forms 
# related to the products application.
class Product
# attr_reader :product
#Acions

  # Method that reads data from the products.txt file and creates a "table" with the product
  # information entered in the products.txt file by the manager or administrator. 
  def initialize #load_product_list
    # This specifies a file to be read for input data about products.
    productsFile = "./products.txt"    
    # Reads each line in the products.txt file and creates an array of strings in the instance
    # variable @product.
    @product = IO.readlines(productsFile)
    # Eliminates the file's header, which is the first line.
    @product.delete(@product[0])
    # Goes through each element of the product array and convert it from string to an array.
    for i in 0...@product.count
      @product[i] = @product[i].chomp.split(/,/)
      # Strips (eliminates) any white spaces before and after each element in the new arrays.
      for i2 in 0...@product[i].count
        @product[i][i2] = @product[i][i2].strip
      end
    end
  end
  
  #Method for accessing the product table created.
  def get_product_table
    @product
  end
  
  # Method to obtain the number of products in the list.
  def get_product_count
    @product.count
  end

  #Method matches the idNum received with the product corresponding to that number.
  def match_product_id(idNum)
    i = idNum.to_i - 1
    @product[i]
  end

#Forms
 
  # Method that displays the product list  
  def display_product_list
    puts;puts;puts;puts;puts;puts;puts;puts
    puts "-"*80
    header = "Product List"
    puts "|#{header.center(78)}|"
    puts "-"*80
    puts "| ID  |             Product             |       SLA       |        Price       |"
    puts "-"*80
    x = @product # x is just a local variable to ease up typing
    for i in 0...x.count
      p1 = i.next; p2 = x[i][0]; p3 = x[i][1]; p4 = x[i][2]; p5 = x[i][3]; p6 = x[i][4]; dol = "$ "
      puts "|#{p1.to_s.center(5)}| #{p2.ljust(32)}|#{p3.center(17)}|#{dol.concat(p5).rjust(19)} |"
      # The manager suggested not to show the "weight" of the products on screen - #{p4.center(8)}
    end
    puts "-"*80
    puts; puts
  end

end