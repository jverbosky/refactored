# Test for random_pairs_weighted_refactored.rb

require "minitest/autorun"
require_relative "random_pairs_weighted_refactored.rb"

class TestRandomPairsWeighted < Minitest::Test

  def test_1_array_with_no_weighted_names_even_number_of_names
    results = random_pairs_weighted(["Abby","Bobby","Cassy","Davey","Emmie","Franky"])
    number_of_pairs = results.count
    assert_equal(3, number_of_pairs)
  end

  def test_2_array_with_no_weighted_names_odd_number_of_names
    results = random_pairs_weighted(["Abby","Bobby","Cassy","Davey","Emmie","Franky","Ginny"])
    number_of_pairs = results.count
    assert_equal(3, number_of_pairs)
  end

  def test_3_array_with_one_weighted_name_odd_number_of_names_confirm_weighted_in_last_pair
    results = random_pairs_weighted(["Abby","Bobby","Cassy","Davey","*Emmie","Franky","Ginny"])
    final_pair = results.last
    weighted = final_pair[0].start_with?("*")
    assert_equal(true, weighted)
  end

 def test_4_array_with_less_than_half_weighted_names_even_number_of_names_confirm_weighted_in_multiple_pairs
    results = random_pairs_weighted(["Abby","Bobby","*Cassy","Davey","*Emmie","Franky"])
    weighted_count = 0
    results.each do |pair|
      if pair[0].start_with?("*")
        weighted_count += 1
      end
    end
    assert_equal(2, weighted_count)
  end

  def test_5_array_with_less_than_half_weighted_names_odd_number_of_names_confirm_weighted_in_multiple_pairs
    results = random_pairs_weighted(["Abby","Bobby","*Cassy","Davey","*Emmie","Franky","Ginny"])
    weighted_count = 0
    results.each do |pair|
      if pair[0].start_with?("*")
        weighted_count += 1
      end
    end
    assert_equal(2, weighted_count)
  end

 def test_6_array_with_half_weighted_names_even_number_of_names_confirm_weighted_in_every_pair
    results = random_pairs_weighted(["Abby","Bobby","*Cassy","Davey","*Emmie","*Franky"])
    number_of_pairs = results.count
    weighted_count = 0
    results.each do |pair|
      if pair[0].start_with?("*")
        weighted_count += 1
      end
    end
    assert_equal(number_of_pairs, weighted_count)
  end

  def test_7_array_with_half_weighted_names_odd_number_of_names_confirm_weighted_in_every_pair
    results = random_pairs_weighted(["Abby","Bobby","*Cassy","Davey","*Emmie","*Franky","Ginny"])
    number_of_pairs = results.count
    weighted_count = 0
    results.each do |pair|
      if pair[0].start_with?("*")
        weighted_count += 1
      end
    end
    assert_equal(number_of_pairs, weighted_count)
  end

 def test_8_array_with_more_weighted_names_odd_number_of_names_confirm_last_pair_not_all_weighted
    results = random_pairs_weighted(["Abby","*Bobby","*Cassy","Davey","*Emmie","*Franky","Ginny"])
    number_of_pairs = results.count
    all_weighted = true
    results.each do |pairs|
      if pairs.length == 3
        pairs.each do |name|
          if name.start_with?("*") == false
            all_weighted = false
          end
        end
      end
    end
    assert_equal(false, all_weighted)
  end

end