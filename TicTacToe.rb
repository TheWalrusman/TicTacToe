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
  attr_reader :board
  def initialize(player_one, player_two, board_size = 3)
    @player_one = player_one
    @player_two = player_two
    @board = Array.new(board_size) { Array.new(board_size) { |index| index = '.' } }
    @current_player = Random.new.rand(2)
    @tmp_regex = "([0-#{@board.length - 1}])" + '(,|\\s)' + "([0-#{@board.length - 1}])"
    @proper_input_regex = Regexp.new @tmp_regex
    print "HI"
  end

  def make_turn
    player_turn = @current_player.even? ? @player_one : @player_two
    print "#{player_turn.name}, it is your turn.\n"
    print "Where do you want to place your piece: use 0-#{@board.length - 1} ',' or space 0-#{@board.length - 1} example 0,0 or 0 1\n"
    user_input = gets.chomp
    until proper_input(user_input)
      print "please follow the format 0-#{@board.length - 1} ',' or space 0-#{@board.length - 1} example 0,0 or 0 1\n"
      print "lets try this again where do you want to place your piece?\n"
      user_input = gets.chomp
    end
    until place_piece(player_turn, user_input[0].to_i, user_input[2].to_i)
      print "Please do not cover up others or your own pieces...\n"
      print "please follow the format 0-#{@board.length - 1} ',' or space 0-#{@board.length - 1} example 0,0 or 0 1\n"
      print "lets try this again where do you want to place your piece?\n"
      user_input = gets.chomp
    end
    if win_checker
      print "#{player_turn.name} you have won the match!"
      return false
    end
    @current_player += 1
    return true
  end

  private
  def win_checker
    current_player_piece_regex = Regexp.new "#{ (@current_player.even? ? @player_one.piece_code : @player_two.piece_code) * 3}"
    (0..@board.length - 1).each do |diagonal|
      return true if @board[diagonal].join('').scan(current_player_piece_regex).length == 1
      return true if @board.transpose[diagonal].join('').scan(current_player_piece_regex).length == 1
    end
    return true if (0..@board.length-1).collect { |index| @board[index][index] }.join('').scan(current_player_piece_regex).length == 1
    return false
  end

  def proper_input(input)
    input.match?(@proper_input_regex)
  end

  def place_piece(player, col, row)
    unless @board[col][row] == '.'
      return false
    end
    @board[col][row] = player.piece_code
    return true
  end
end
player_one = Player.new('Kyle')
player_two = Player.new('Will')
game_board = Board.new(player_one, player_two)
print game_board.board
print game_board.make_turn
while game_board.make_turn
  print game_board.board
end
print game_board.board
print "HI"