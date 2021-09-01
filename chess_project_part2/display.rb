require 'colorize'
require_relative 'cursor.rb'

class Display
    def initialize(board)
        @cursor = Cursor.new([0,0], board)
        @board = board
    end

    def render

    end



end