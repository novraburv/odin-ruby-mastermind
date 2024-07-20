# frozen_string_literal: true

require_relative 'code_breaker'
require_relative 'code_maker'
require_relative 'helpers'

# control game loop
class Game
  COLORS = %i[red green blue yellow orange purple].freeze

  def initialize
    @breaker = CodeBreaker.new
    @maker = CodeMaker.new
    @player_role = nil
  end

  def start
    Helpers.select_role
    create_code
    commence_loops
  end

  private

  def commence_loops
    12.times do
      break_the_code
      result = Helpers.evaluate(@maker, @breaker)
      puts result.join(' ')
      if result.length == 4 && result.all? { |x| x == 'black' }
        puts 'congratulations, you won'
        break
      end
      puts 'incorrect! try again.'
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
    # reset previous guess
    @breaker.reset
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
end
