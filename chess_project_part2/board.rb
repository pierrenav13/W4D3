require_relative "piece.rb"
require_relative "modules.rb"
require "byebug"
class Board
    attr_reader :rows
    # def self.setup_board
    #     arr = Array.new(8) {Array.new(8)}

    #     arr.each.with_index do |row, i|
    #         b = Board.new
    #         if i == 1
    #             idx = 0
    #             row = row.each do |ele| 
    #                 Pawn.new("black", , [i, idx], :P)
    #                 idx += 1
    #             end
    #         elsif i == 6
    #             idx = 0
    #             row = row.each do |ele| 
    #                 Pawn.new("white", Board.new, [i, idx], :P)
    #                 idx += 1
    #             end
    #         elsif i == 0
    #             row[0] = Rook.new("black", )
    #             row.map! {|ele| NullPiece.new}
    #         end
    #     end
    # end

    def initialize
        @rows = Array.new(8) {Array.new(8)}
        pieces = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]
        symbols = [:R, :k, :B, :K, :Q, :B, :k, :R]

        @rows.each.with_index do |row, i|
            if i == 1
                row.each.with_index do |ele, i2|
                    row[i2] = Pawn.new("black", self, [i, i2], :P)
                end
            elsif i == 6
                row.each.with_index do |ele, i2|
                    row[i2] = Pawn.new("white", self, [i, i2], :P)
                end
            elsif i == 0
                row.each.with_index do |ele, i2|
                    row[i2] = pieces[i2].new("black", self, [i, i2], symbols[i2])
                end
            elsif i == 7
                row.each.with_index do |ele, i2|
                    row[i2] = pieces[i2].new("white", self, [i, i2], symbols[i2])
                end
            else
                row.map!{|ele| NullPiece.instance }
            end
        end
    end

    def[](pos)
        row, col = pos
        @rows[row][col]
    end

    def[]=(pos, value)
        row, col = pos
        @rows[row][col] = value
    end

    def move_piece(start_pos, end_pos)
        raise "A position is not valid" unless valid_move?(start_pos) && valid_move?(end_pos)
        raise "No piece at start position" if self[start_pos].is_a?(NullPiece)
        # debugger
        raise "End position invalid" unless self[start_pos].moves.include?(end_pos)
        self[end_pos] = self[start_pos]
        self[start_pos] = NullPiece.instance
    end

    def valid_move?(pos)
        pos.all? {|ele| ele >= 0 && ele <= 7}
    end

    def inspect
        {
        rows: @rows.map {|row| row.map{|ele| ele.symbol}}
        }.inspect
    end

end

