# Test for hangman_refactored.rb

require "minitest/autorun"
require_relative "hangman_refactored.rb"

class TestHangmanRefactored < Minitest::Test

  # Run test if testing from Windows, if not then comment out
  def test_1_use_cls_command_if_system_is_Windows_based
    # Note - will return true if running on Windows-based system
    # Testing here on Windows-based system
    results = clear_screen()
    assert_equal(system("cls"), results)
  end

  #Run test if testing from Unix (Mac/Linux), if not then comment out
  # def test_1_use_clear_command_if_system_is_Unix_based
  #   # Note - will return true on Unix-based system
  #   # Testing here on Windows-based system
  #   results = clear_screen()
  #   assert_equal(system("clear"), results)
  # end

  # I'll be honest and admit that I expected "\n\n" as the output
  # Assuming this method returning the argument due to the puts statement
  # Based on this, will not create tests for other methods that simply output text
  # i.e. score(), letters(), hangman(), congratulations(), winner(), sorry() and loser()
  def test_2_verify_margin_method_outputs_correct_number_of_newlines
    results = margin(2)
    assert_equal(2, results)
  end

  # Unable to test start_game(), so refactoring accordingly
  def test_3_initialize_build_word_array_with_placeholder_underscores
    $word = "testing"
    results = initialize_word()
    assert_equal(["_", "_", "_", "_", "_", "_", "_"], $build_word)
  end

  # Not sure how to test start_game() and user_input() methods that call other methods
  # def test_4_verify_start_game_method_calls_other_methods
  #   results = start_game()
  #   assert_equal(initialize_word() && clear_screen() && user_input(), results)
  # end

end