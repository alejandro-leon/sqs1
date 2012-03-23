# The "Utility" class handles miscelaneous tasks.
class Utility

  def line
    puts "Holita"
  end
#Actions
  def send_current_user(username)
    @currentUser = username
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