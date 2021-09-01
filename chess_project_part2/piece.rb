require_relative 'modules.rb'
require_relative "board.rb"
require "singleton"
require "byebug"

class Piece 
    attr_reader :pos, :color, :board
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    # def valid_moves
    #     self.moves(@pos).select do |ele|
    #         ele.none?{ |i| i < 0 } &&
    #         ele.none?{ |i| i > 7 }
    #     end
    # end

    def pos=(value)
        self.pos = value
    end

end

class King < Piece
    attr_reader :symbol
    include Stepable

    def initialize(color, board, pos, symbol)
        super(color, board, pos)
        @symbol = symbol
    end

    protected
    def move_diffs
        result = []
        (-1..1).each do |i|
            (-1..1).each do |i2|
                result << [i, i2]
            end
        end
        result
    end
end

class Knight < Piece
    attr_reader :symbol
    include Stepable

    def initialize(color, board, pos, symbol)
        super(color, board, pos)
        @symbol = symbol
    end

    protected
    def move_diffs
        [[2, 1],
        [2, -1],
        [-1, 2],
        [-1, -2],
        [1, 2],
        [1, -2],
        [-2, 1],
        [-2, -2]]
    end
end

class Rook < Piece
    attr_reader :symbol
    include Slidable

    def initialize(color,board,pos,symbol)
        super(color,board,pos)
        @symbol = symbol
    end

    protected
    def move_dirs
        self.get_horizontal
    end
end

class Bishop < Piece
    attr_reader :symbol
    include Slidable

    def initialize(color,board,pos,symbol)
        super(color,board,pos)
        @symbol = symbol
    end

    protected
    def move_dirs
        self.get_diagonal
    end
end

class Queen < Piece
    attr_reader :symbol
    include Slidable

    def initialize(color,board,pos,symbol)
        super(color,board,pos)
        @symbol = symbol
    end

    protected
    def move_dirs
        self.get_diagonal + self.get_horizontal
    end
end

class NullPiece < Piece
    attr_reader :symbol
    include Singleton

    def initialize
        @symbol = " "
    end

    def moves
    end
end

class Pawn < Piece
    attr_reader :symbol

    def initialize(color,board,pos,symbol)
        super(color,board,pos)
        @symbol = symbol
    end

    def moves
        result = []
        self.forward_steps.each do |pos|
            possible_move = [self.pos.first + pos.first, self.pos.last + pos.last]
            if self.board[possible_move].is_a?(NullPiece)
                result << possible_move
            end
        end

        self.side_attack.each do |pos|
            possible_move = [self.pos.first + pos.first, self.pos.last + pos.last]
            if !self.board[possible_move].is_a?(NullPiece) && self.board[possible_move].color != self.color
                result << possible_move
            end
        end
        result
    end

    private
    def at_start_row?
        @pos.first == 1
    end

    def forward_dir
        if self.color == "white"
            return -1
        else
            return 1
        end
    end

    def forward_steps
        result = []
        if self.at_start_row?
            result << [self.forward_dir, 0]
            result << [self.forward_dir * 2, 0]
        else
            result << [self.forward_dir, 0]
        end
        result
    end

    def side_attack
        result = []
        result << [self.forward_dir, self.forward_dir]
        result << [self.forward_dir, -(self.forward_dir)]
        result
    end
end