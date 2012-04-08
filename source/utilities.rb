# The "Utility" class handles miscelaneous tasks.  In this case, the banner.
class Utility

  #  software version
  VERSION = "0.1.9"

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
        puts "Hello, #{$userName.ljust(52)} #{VERSION.ljust(21)}"; puts #; puts
      when 2
        puts "#{VERSION.rjust(65)}"; puts; puts
      when 3
    puts"/ \\ / \\ / \\ /  \\ / \\ / \\ / \\     / \\ / \\       / \\ / \\ / \\    ".center(80) 
    puts"| W | E | L | C  | O | M | E |   | T | O |     | T | H | E |   ".center(80)
    puts" / \\ / \\ / \\ / \\ / \\  / \\ / \\ / \\ / \\ / \\ / \\ / \\   / \\ / \\ / \\ / \\ / \\ / \\".center(80)
    puts"| S | A | L | E | S || Q | U | O | T | I | N | G | | S | Y | S | T | E | M |".center(80)
    puts" \\ / \\ / \\ / \\ / \\ /  \\ / \\ / \\ / \\ / \\ / \\ / \\ /   \\ / \\ / \\ / \\ / \\ / \\ /".center(80)
    puts "Press \"Enter\" to start"; gets
      when 4
        puts "Bye, #{$userName.ljust(54)} #{VERSION.ljust(21)}"; puts; 
        puts "Thank you for using SQS!".center(80); puts
    end
  end
end
