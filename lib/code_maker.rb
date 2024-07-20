# frozen_string_literal: true

# save information about code created by codemaker
class CodeMaker
  attr_reader :code

  def initialize
    @code = []
  end

  def add_color(array)
    array.each { |col| @code << col }
  end
end
