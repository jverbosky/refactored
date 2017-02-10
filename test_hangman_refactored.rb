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

  # # Run test if testing from Unix (Mac/Linux), if not then comment out
  # def test_1_use_clear_command_if_system_is_Unix_based
  #   # Note - will return true on Unix-based system
  #   # Testing here on Windows-based system
  #   results = clear_screen()
  #   assert_equal(system("clear"), results)
  # end

  # I'll be honest and admit that I expected "\n\n" as the output
  # Assuming this method returning the argument due to the puts statement
  # Based on this, will not create tests for other methods that output text
  # i.e. score(), letters(), user_input(), hangman(), congratulations(), winner(), sorry() and loser()
  def test_2_verify_margin_method_outputs_correct_number_of_newlines
    results = margin(2)
    assert_equal(2, results)
  end

  # Unable to test start_game(), so refactoring accordingly
  def test_3_initialize_build_word_array_with_placeholder_underscores
    $build_word = []
    $word = "testing"
    results = initialize_word()
    assert_equal(["_", "_", "_", "_", "_", "_", "_"], $build_word)
  end

  # # Not sure how to test start_game() and user_input() methods that call other methods
  # def test_4_verify_start_game_method_calls_other_methods
  #   results = start_game()
  #   assert_equal(initialize_word() && clear_screen() && user_input(), results)
  # end

  # Verify that if a number is entered, that it is not added to the bucket array
  # Note - need to comment out user_input() in else statement (line 98) for test to work,
  #   otherwise comment out this test
  def test_5_verify_number_not_added_to_bucket_array
    $bucket = []
    letter = "7"
    results = good_letter(letter)
    assert_equal([], $bucket)
  end

  # Verify that if a letter already in bucket array is entered, that it is not added to the bucket array again
  # Note - need to comment out user_input() in else statement (line 98) for test to work,
  #   otherwise comment out this test
  def test_6_verify_number_not_added_to_bucket_array_if_already_present
    $bucket = ["b"]
    letter = "b"
    results = good_letter(letter)
    assert_equal(["b"], $bucket)
  end

  # Verify that if a single letter is entered, that it is added to the bucket array
  # Again, not sure how to verify that other methods are called following this or if there's a better way
  # Note - need to comment out letter_test(letter) in elsif statement (line 95) for test to work,
  #   otherwise comment out this test
  def test_7_verify_letter_is_added_to_bucket_array_if_good
    $bucket = []
    letter = "a"
    results = good_letter(letter)
    assert_equal(["a"], $bucket)
  end





end