require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/game'

class GameTest < Minitest::Test
  def test_game_starts_with_good_luck_message
    skip
    #can move to response_generator_test just keeping it here for now
    rg = ResponseGenerator.new
    assert_equal "Good Luck!", rg.game_start.output
  end

  def test_reponse_generator_guess_count_as_zero
    skip
    rg = ResponseGenerator.new
    assert_equal 0, response_generator.guess_count
  end

  def test_game_generates_random_number
    rg = ResponseGenerator.new
    correct_num_one  = rg.correct_number
    rg = ResponseGenerator.new
    correct_num_two  = rg.correct_number
    refute correct_num_one == correct_num_two
  end

  def test_game_count_increases_with_first_guess
    skip
    rg = ResponseGenerator.new
    rg.start_game
    assert_equal 0, rg.guess_count
    rg.guessing_game
    assert_equal 1, rg.guess_count
  end

  def test_game_count_increases_with_second_guess
    skip
    rg = ResponseGenerator.new
    rg.start_game
    assert_equal 0, game.guess_count
    rg.guessing_game
    assert_equal 1, game.guess_count
    rg.guessing_game
    assert_equal 2, game.guess_count
  end
