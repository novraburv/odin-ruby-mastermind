# frozen_string_literal: true

require_relative 'code_breaker'
require_relative 'code_maker'

# control game loop
class Game
  COLORS = %i[red green blue yellow orange purple].freeze

  def initialize
    @breaker = CodeBreaker.new
    @maker = CodeMaker.new
    @player_role = nil
  end

  def start
    select_role
    create_code
    12.times do
      break_the_code
      result = evaluate(@maker, @breaker)
      puts result.join(' ')
      if result.length == 4 && result.all? { |x| x == 'black' }
        puts 'congratulations, you won'
        break
      else
        puts 'incorrect! try again.'
        @breaker.reset
      end
    end
  end

  # this section is for player
  def create_code
    puts 'create a combination of four colors'
    puts "available colors #{COLORS}"
    code = gets.chomp.split(' ').map(&:to_sym)
    @maker.add_color code
  end

  def break_the_code
    puts 'break the code'
    puts 'use a combination of four colors'
    puts "available colors #{COLORS}"
    code = gets.chomp.split(' ').map(&:to_sym)
    @breaker.add_guess code
  end

  # this section is for cpu
  def generate_code
    puts 'generating code...'
    code = COLORS.sample(4).shuffle
    @maker.add_color code
  end

  # helper functions
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
    code = codemaker.code
    guess = codebreaker.guess
    result = []

    code.each_index do |i|
      if code[i] == guess[i]
        result << 'black'
      elsif guess.include? code[i]
        result << 'white'
      end
    end
    result.sort
  end
end
