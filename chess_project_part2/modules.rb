# require_relative 'piece.rb'

module Stepable
    def moves
        moves = []
        self.move_diffs.each do |ele|
            possible_move = [self.pos.first + ele.first, self.pos.last + ele.last]
            if self.board[possible_move].is_a?(NullPiece) || self.board[possible_move].color != self.color
                moves << possible_move
            end
        end
        moves.select {|ele| self.board.valid_move?(ele)}
    end

    private
    def move_diffs
    end
end

module Slidable

    def moves
        # moves = []
        # self.move_dirs.each do |ele|
        #     moves << [self.pos.first + ele.first, self.pos.last + ele.last]
        # end
        # moves.select {|ele| self.board.valid_move?(ele)}
        dirs = self.move_dirs
        dirs.select {|ele| self.board.valid_move?(ele)}
    end
    
    def horizontal_dirs
        directions = []
        [[0,1], [0,-1], [-1,0], [1,0]].each do |dx,dy|
            directions += self.grow_unblocked_moves_in_dir(dx,dy)
        end
        directions
    end

    def diagonal_dirs
        directions = []
        [[-1,1], [-1, -1], [1,-1], [1,1]].each do |dx, dy|
            directions += self.grow_unblocked_moves_in_dir(dx,dy)
        end
        directions
    end

    def get_diagonal
        self.diagonal_dirs
    end

    def get_horizontal
        self.horizontal_dirs
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        moves = []
        x,y = self.pos
        new_pos = [x+dx, y+dy]
        while self.board[new_pos].is_a?(NullPiece) || self.board[new_pos].color != self.color
            moves << new_pos
            new_pos = [new_pos.first + dx, new_pos.last + dy]
        end
        moves.select {|ele| self.board.valid_move?(ele)}
    end


end