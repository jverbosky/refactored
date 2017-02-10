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

  # Unable to test start_game(), so refactoring accordingly
  def test_2_initialize_build_word_array_with_placeholder_underscores
    $build_word = []
    $word = "testing"
    results = initialize_word()
    assert_equal(["_", "_", "_", "_", "_", "_", "_"], $build_word)
  end

  # # Not sure how to test start_game() and user_input() methods that call other methods
  # def test_3_verify_start_game_method_calls_other_methods
  #   results = start_game()
  #   assert_equal(initialize_word() && clear_screen() && user_input(), results)
  # end

  # # Verify that if a number is entered, that it is not added to the bucket array
  # # Note - need to comment out user_input() in else statement (line 98) for test to work,
  # #   otherwise comment out this test
  # def test_4_verify_number_not_added_to_bucket_array
  #   $bucket = []
  #   letter = "7"
  #   results = good_letter(letter)
  #   assert_equal([], $bucket)
  # end

  # # Verify that if a letter already in bucket array is entered, that it is not added to the bucket array again
  # # Note - need to comment out user_input() in else statement (line 98) for test to work,
  # #   otherwise comment out this test
  # def test_5_verify_number_not_added_to_bucket_array_if_already_present
  #   $bucket = ["b"]
  #   letter = "b"
  #   results = good_letter(letter)
  #   assert_equal(["b"], $bucket)
  # end

  # # Verify that if a single letter is entered, that it is added to the bucket array
  # # Again, not sure how to verify that other methods are called following this or if there's a better way
  # # Note - need to comment out letter_test(letter) in elsif statement (line 95) for test to work,
  # #   otherwise comment out this test
  # def test_6_verify_letter_is_added_to_bucket_array_if_good
  #   $bucket = []
  #   letter = "a"
  #   results = good_letter(letter)
  #   assert_equal(["a"], $bucket)
  # end

  # # Verify that letter is in the current word
  # # Note - need to comment out original method calls (line 105) for test to work,
  # #   otherwise comment out this test
  # def test_7_return_true_if_letter_in_word
  #   $word = "test"
  #   letter = "e"
  #   results = letter_test(letter)
  #   assert_equal(true, results)
  # end

  # # Verify that letter is not in the current word
  # # Note - need to comment out original method calls (line 105) and uncomment the subsequent line
  # #   for test to work, otherwise comment out this test
  # def test_8_return_false_if_letter_not_in_word
  #   $word = "test"
  #   letter = "d"
  #   results = letter_test(letter)
  #   assert_equal(false, results)
  # end

  # # Verify the positions of a letter in a word
  # # Note - need to comment out original method call (line 119) and uncomment the subsequent line
  # #   for test to work, otherwise comment out this test
  # def test_9_return_positions_of_letter_in_word
  #   $word = "repeated"
  #   letter = "e"
  #   results = find_locations(letter)
  #   assert_equal([1, 3, 6], results)
  # end

  # Verify that letter gets placed into correct locations in $build_word array
  # Note - need to comment out original method call (line 128) for test to work,
  #   otherwise comment out this test
  def test_10_replace_appropriate_placeholders_with_letter
    $build_word = ["_", "_", "_", "_", "_", "_", "_", "_"]
    letter = "e"
    locations = [1, 3, 6]
    results = add_letter(letter, locations)
    assert_equal(["_", "e", "_", "e", "_", "_", "e", "_"], $build_word)
  end

end