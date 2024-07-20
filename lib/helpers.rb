# frozen_string_literal: true

# helper functions
module Helpers
  module_function

  def select_role
    puts 'Will you be the Code Maker or the Code Breaker'
    puts 'enter "MAKER" or "BREAKER"'
    choice = gets.chomp.upcase
    if %w[MAKER BREAKER].include?(choice)
      @player_role = choice
    else
      puts 'try again...'
      select_role
    end
  end

  def evaluate(codemaker, codebreaker)
    result = []
    codemaker.code.each_index do |i|
      if codemaker.code[i] == codebreaker.guess[i]
        result << 'black'
      elsif codebreaker.guess.include?(codemaker.code[i])
        result << 'white'
      end
    end
    result.sort
  end
end
