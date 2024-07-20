# frozen_string_literal: true

# save information about the guess from codebreaker
class CodeBreaker
  attr_reader :guess

  def initialize
    @guess = []
  end

  def add_guess(array)
    array.each { |col| @guess << col }
  end

  def reset
    @guess.clear
  end
end
