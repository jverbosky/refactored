###############################################################################
### Very basic hangman game inspired by TechHire interview with Mined Minds ###
###############################################################################
######################## Rewritten in Ruby (2017-02-07) #######################
#############################  by John C. Verbosky ############################
###############################################################################
# Features:                                                                   #
# - animations for winning and losing                                         #
# - ability to start a new game or exit after win/loss                        #
# - cumulative score                                                          #
###############################################################################
# Note:                                                                       #
# - runs correctly on Windows x86, Mac and Linux                              #
# - does not work correctly on Windows with 64-bit Ruby                       #
#   - run with 32-bit Ruby on 64-bit Windows (see notes)                      #
###############################################################################

# Load Win32API class if running on Windows - use with getkey()
$use_stty = begin  # check the current terminal session
  require 'Win32API'  # load the Win32API class for Windows systems
  false  # if this succeeds, the system is Windows so return false
rescue LoadError  # if this fails, the system is Unix
  true  # so return true and use Unix commands
end

# array of mystery words
$words = ["research", "persistence", "dedication", "curiosity", "troubleshoot", "energetic", "organization",
          "communication", "development", "loyalty", "adaptable", "creativity", "improvement", "dependable",
          "teamwork", "collaboration", "optimistic", "focused", "meticulous", "effective", "inspired"]

$word = $words.sample  # select a random word from the words array
$bucket = []  # array to hold all letters that have been entered to guess
$build_word = []  # array to hold guessed letters that are found in mystery word
$wrong_count = []  # array to hold guessed letters that are not found in mystery word
$games_won = 0  # counter for games won
$games_lost = 0  # counter for games lost

# Method to clear the screen regardless of OS
def clear_screen()
  $use_stty ? system("clear") : system("cls")
end

# Method to make tweaking margins easier
def margin(number)
  puts "\n" * number  # output a blank line "number" of times
end

# Method to display the cumulative score of games won and lost
def score()
  margin(1)
  puts "  Score"
  puts "  -----"
  puts "  Won: #{$games_won}    Lost: #{$games_lost}"
end

# Method to display guessed letters
def letters()
  puts "  Word:     " + $build_word.join(" ")  # display the correctly guessed letters and placeholders
  margin(1)
  puts "  Letters:  " + $bucket.join(" ")  # display all of the guessed letters
  margin(2)
end

# Method to initialize $build_word array with an underscore for every letter in $word
def initialize_word()
  $word.length.times { $build_word.push("_") }
end

# Method to start game
def start_game()
  initialize_word()
  clear_screen()
  user_input()
end

# Method that acts as primary starting/return point for other methods
def user_input()
  score()  # display the cumulative score
  hangman($wrong_count.length)  # display the current progressive hangman "image" based on wrong guesses
  letters()  # display the correctly guessed letters and placeholders
  print "  Please enter a letter: "  # prompt the user for a letter
  letter = gets.chomp  # assign the letter to a variable
  good_letter(letter)  # pass the user-specified letter to good_letter()
end

# Method that checks the user-specified letter for a few things
def good_letter(letter)
  clear_screen()  # Clear the screen
  if $bucket.include? letter  # check to see if letter has already been guessed and reprompt if so
    puts "  You already guessed that one - TRY AGAIN!"
    # user_input()
  elsif letter[/[a-zA-Z]+/] and letter.length == 1  # check is a single -letter- has been entered
    $bucket.push(letter)  # if so, add it to the bucket list
    # letter_test(letter)  # then pass it to letter_test()
  else  # if multiple letters, non-alpha characters or nothing has been entered
    puts "  Enter a single letter - TRY AGAIN!"  # reprompt user to try again
    # user_input()
  end
end

# Method that checks to see if letter is in the mystery word
def letter_test(letter)
  # If it is in the word pass it to find_locations(), if not pass it to wrong_letter()
  # $word.include?(letter) ? find_locations(letter) : wrong_letter(letter)
  $word.include?(letter)  # use for testing
end

# Method that finds all locations of a letter in the word
def find_locations(letter)
  locations = []  # array for the index (position) of all instances of the letter in the word
  last_index = 0  # dual-purpose variable that holds the index (position) of the letter and the .index offset
  occurrences = $word.count letter  # variable used to control do loop iteration count
  occurrences.times do  # for every occurrence of the letter in the word
    last_index = $word.index(letter, last_index)  # determine the position of the letter in the word
    locations.push(last_index)  # push the position of the letter to the location array
    last_index += 1  # increment last_index by 1 to target the next occurrence of the letter (via .index offset)
  end
  # add_letter(letter, locations)  # pass the user-specified letter and array of locations to add_letter()
  return locations  # use for testing
end

# Method to populate $build_word with every occurrence of a letter
def add_letter(letter, locations)
  # for each occurrence of a letter, add the letter to the correct location in $build-word
  locations.each { |location| $build_word[location] = letter }
  # word_test()  # then run word_test()
end

# Method to compare the current build_word array against the mystery word
def word_test()
  if $build_word.join == $word  # if $build_word equals $word, the user won
    $games_won += 1  # so increase the games_won score by 1
    # winner(1)  # and start winner() on frame 1 (animation count 1)
  else  # if they don't match, run user_input() for another letter
    user_input()
  end
end

# Method that receives non-mystery word letter and adds it to the wrong_count array
def wrong_letter(letter)
  if $wrong_count.length < 9  # if the wrong_count list has less than 9 letters
    $wrong_count.push(letter)  # then add the letter to the list
    # user_input()  # run user_input() again
  else  # if this is the tenth wrong letter, it's game over
    $games_lost += 1  # so increase the games_lost score by 1
    # loser(5)  # and start loser() on frame 1 (animation count 5)
  end
end

# Method to progressively draw the hangman stages as incorrect letters are guessed
def hangman(count)
  if count == 0
    margin(12)
  elsif count == 1
    margin(8)
    puts "   _________"
    margin(3)
  elsif count == 2
    margin(2)
    6.times { puts "       |" }
    puts "   ____|____"
    margin(3)
  elsif count == 3
    margin(1)
    puts "        ______"
    6.times { puts "       |" }
    puts "   ____|____"
    margin(3)
  elsif count == 4
    margin(1)
    puts "        ______"
    2.times { puts "       |      |" }
    4.times { puts "       |" }
    puts "   ____|____"
    margin(3)
  elsif count == 5
    margin(1)
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    3.times { puts "       |" }
    puts "   ____|____"
    margin(3)
  elsif count == 6
    margin(1)
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    puts "       |      |"
    2.times { puts "       |" }
    puts "   ____|____"
    margin(3)
  elsif count == 7
    margin(1)
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    puts "       |     /|"
    2.times { puts "       |" }
    puts "   ____|____"
    margin(3)
  elsif count == 8
    margin(1)
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    puts "       |     /|\\"
    2.times { puts "       |" }
    puts "   ____|____"
    margin(3)
  else
    margin(1)
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    puts "       |     /|\\"
    puts "       |     /"
    puts "       |"
    puts "   ____|____"
    margin(3)
  end
end

# Method to return the ASCII code last key pressed, or nil if none
def getkey()
  if $use_stty  # if system is Unix
    system('stty raw -echo') # use raw mode, no echo
    character = (STDIN.read_nonblock(1).ord rescue nil)
    system('stty -raw echo') # reset terminal mode
    return character
  else  # otherwise use Win32API class methods for Windows system
    return Win32API.new('crtdll', '_kbhit', [ ], 'I').Call.zero? ? nil : Win32API.new('crtdll', '_getch', [ ], 'L').Call
  end
end

# Method to handle endgame items (animations, start a new game, exit game) - runs after each animation frame
def game_over(ani_count)
  key = getkey()  # variable for last key pressed
  clear_screen()  # Clear the screen
  if key != nil  # check to see if a key was pressed during winner/loser animation
    if key != 27  # if the user presses any key except Esc (27)
      $word = $words.sample  # select a new random word
      $bucket = []  # clear all global arrays
      $build_word = []
      $wrong_count = []
      start_game()  #  and start a new game
    elsif key == 27  # if the user presses the Esc key (27)
      puts "Exiting game..."  # and exit the game
      margin(1)
    end
  elsif ani_count < 5  # if no keypress and animation count < 5
    winner(ani_count)  # run winner() with the current animation count
  else  # if no keypress and animation count >= 5
    loser(ani_count)  # run loser() with the current animation count
  end
end

# Method to print repetitive congratulations text in winner() animation
def congratulations()
  margin(2)
  puts "       ---CONGRATULATIONS---"
  margin(1)
  puts "        YOU WON THE GAME!!!"
  margin(2)
end

# Method to display winner() animation
def winner(ani_count)
  if ani_count == 1  # winner animation frame 1
    score()
    congratulations()
    puts "   \\O/    \\O_  \\O/  _O/    \\O/ "
    puts "    |    _/     |     \\_    |  "
    puts "   / \\    |    / \\    |    / \\ "
    margin(2)
    letters()
    puts " - Press any key to play again or Esc to quit -"
    sleep(0.5)  # wait 1/2 second for smooth animation
    game_over(2)  # run the game_over function to see if user has pressed a key
  elsif ani_count == 2  # winner animation frame 2
    score()
    congratulations()
    puts "    \\O_  \\O/  _O/    \\O/    \\O_ "
    puts "   _/     |     \\_    |    _/   "
    puts "    |    / \\    |    / \\    |   "
    margin(2)
    letters()
    puts " \\ Press any key to play again or Esc to quit \\"
    sleep(0.5)
    game_over(3)
  elsif ani_count == 3  # winner animation frame 3
    score()
    congratulations()
    puts "   \\O/  _O/    \\O/    \\O_  \\O/ "
    puts "    |     \\_    |    _/     |  "
    puts "   / \\    |    / \\    |    / \\ "
    margin(2)
    letters()
    puts " | Press any key to play again or Esc to quit |"
    sleep(0.5)
    game_over(4)
  else  # winner animation frame 4
    score()
    congratulations()
    puts "  _O/    \\O/    \\O_  \\O/  _O/  "
    puts "    \\_    |    _/     |     \\_ "
    puts "    |    / \\    |    / \\    |  "
    margin(2)
    letters()
    puts " / Press any key to play again or Esc to quit /"
    sleep(0.5)
    game_over(1)
  end
end

# Method to print repetitive game over text in loser() animation
def sorry()
  margin(1)
  puts "  SORRY - GAME OVER!"
  margin(1)
end

# Method to display loser() animation
def loser(ani_count)
  if ani_count == 5  #loser animation frame 1
    score()
    margin(1)
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    puts "       |     /|\\"
    puts "       |     / \\"
    puts "       |"
    puts "   ____|____"
    sorry()
    letters()
    puts " - Press any key to play again or Esc to quit -"
    sleep(0.5)
    game_over(6)  # run the game_over function to see if user has pressed a key
  elsif ani_count == 6  #loser animation frame 2
    score()
    margin(1)
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |     _O_"
    puts "       |      |"
    puts "       |     / \\"
    puts "       |"
    puts "   ____|____"
    sorry()
    letters()
    puts " \\ Press any key to play again or Esc to quit \\"
    sleep(0.5)
    game_over(7)
  elsif ani_count == 7  #loser animation frame 3
    score()
    margin(1)
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |     \\O/"
    puts "       |      |"
    puts "       |     / \\"
    puts "       |"
    puts "   ____|____"
    sorry()
    letters()
    puts " | Press any key to play again or Esc to quit |"
    sleep(0.5)
    game_over(8)
  else  # loser animation frame 4
    score()
    margin(1)
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |     _O_"
    puts "       |      |"
    puts "       |     / \\"
    puts "       |"
    puts "   ____|____"
    sorry()
    letters()
    puts " / Press any key to play again or Esc to quit /"
    sleep(0.5)
    game_over(5)
  end
end

# start_game()  # Comment out for testing