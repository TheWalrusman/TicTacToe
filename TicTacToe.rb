class Player
  attr_reader :name, :player_count, :PLAYER_DEFAULT_PIECES
  attr_accessor :piece_code
  @@PLAYER_DEFAULT_PIECES = ['X', 'O']
  @@player_count = 0
  def initialize(name, piece_code = 'none')
    @name = name
    @@player_count += 1
    @piece_code = if piece_code == 'none'
                    @@PLAYER_DEFAULT_PIECES[@@player_count % 2]
                  else
                    piece_code
                  end
  end
end




class Board
  def initialize(player_one, player_two, board_size = 3)
    @player_one = player_one
    @player_two = player_two
    @board = Array.new(board_size, Array.new(board_size) { |index| index = '.' })
    @current_player = Random.new.rand(2)
    @tmp_regex = "([0-#{@board.length - 1}])" + '(,|\\s)' + "([0-#{@board.length - 1}])"
    @proper_input_regex = Regexp.new @tmp_regex
    print "HI"
  end

  def make_turn
    player_turn = @current_player.even? ? @player_one : @player_two
    print "#{player_turn.name}, it is your turn.\n"
    print "Where do you want to place your piece: use 0-#{@board.length - 1} ',' or space 0-#{@board.length - 1} example 0,0 or 0 1\n"

    until gets.chomp.match?(@proper_input_regex)
      print "please follow the format 0-#{@board.length - 1} ',' or space 0-#{@board.length - 1}example 0,0 or 0 1\n"
      print "lets try this again where do you want to place your piece?\n"
    end

  end
end
player_one = Player.new('Kyle')
player_two = Player.new('Will')
game_board = Board.new(player_one, player_two)
game_board.make_turn
print "HI"