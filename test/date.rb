class Next

def save_new_quote(quoteArray)
  loop = true
  while loop == true
    puts"Save file as:"
    newFile = gets.chomp
    newFile = newFile.partition(".")
    newFile = newFile[0]<<".txt"
    error = ""
    puts "#{error}Replace any file named \"#{newFile}\" where this application resides?" 
    puts " (1) Replace          (2) Cancel     "
    option = gets.to_i
    if (option > 0) && (option < 3)
      case option
      when 1
       loop = false
        File.open(newFile,"w") do |f|
        f.write quoteArray
        end
      when 2
        loop = false
      end
    else
      error = "Invalid input. "
      loop = true
    end
  end
end # save_quote_report

end
    while loop == true
      fromUtils2.display_logo_banner(1)
      puts"Save the new Sales Quote as:"
      newFile = gets.chomp
      newFile = newFile.partition(".")
      newFile = newFile[0]<<".txt"
      fromUtils2.display_logo_banner(1)
      error = ""
      puts "#{error}Will replace any file named \"#{newFile}\" in the destination directory!" 
      puts " (1) Replace          (2) Cancel     "
      option = gets.to_i
      if (option > 0) && (option < 3)
        case option
        when 1
          
          File.open(newFile,"w") do |f|
          f.write $salesQuote
          fromUtils2.display_logo_banner(1)
          puts "Save was successful!"
          sleep 2
          loop = false
          returnValue = true
          end
        when 2
          fromUtils2.display_logo_banner(1)
          put "Save was cancelled!"
          sleep 2
          loop = false
          returnValue = false
        end
      else
        error = "Invalid input. "
        loop = true
      end
    end
    return returnValue
    