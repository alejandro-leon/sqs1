# Test to make method return a false value,
# array "a" doesn't have the value "4"

a = [1, 3, 2, 9]
i = 0
while i < a.count
  puts i
  validValue = a[i]
  validValue == 4
  i +=1
end

# Putting a token so the returning value is true or false (set to 0 for false)
a = [1, 3, 2, 9]
i = 0
while i < a.count
  puts i
  validValue = a[i]
  val = validValue == 2
  if val == true
    token = 1
  end
  i += 1
end
token == 0

# Testing token with for loop
a = [1, 3, 2, 9]
i = 0
for i in 0..a.count
  validValue = a[i]
  val = validValue == 7
  i += 1
  if val == true
    token = 1
  end
end
token == 1

# Returns true if "n" is an integer greater than 0 and less than 100,000,000.
def quantity_valid?(n)
  n = n.to_i
  (n > 0) && (n < 100000000) #range tested with value equivalence analysis.
end

# Returns true if "id_number" is in the range of the product options
def id_valid?(id_number,max_number_of_products)
  (id_number >= 1) && (id_number <= max_number_of_products)
end

#Gives me a fail when using "or" instead of "and""
      if sure == 1 and 2
        puts "Invalid option. "
      else sure != 2
        puts "2"
      end