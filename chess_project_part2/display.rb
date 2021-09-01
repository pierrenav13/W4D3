require 'colorize'
require_relative "board.rb"
require_relative 'cursor.rb'

class Display
    attr_reader :cursor
    def initialize(board)
        @cursor = Cursor.new([0,0], board)
        @board = board
    end

    def render
        @board.rows.each do |row|
            symbols = row.map do |ele| 
                if ele.pos == @cursor.cursor_pos
                    ele.symbol.to_s.red
                else
                    ele.symbol.to_s
                end
            end
            puts symbols.join(" ")
        end
        puts
    end

    def display_loop
        self.render
        until @cursor.get_input == @cursor.cursor_pos
            self.render
            # @cursor.get_input
        end
    end
end

d = Display.new(Board.new)
d.display_loop