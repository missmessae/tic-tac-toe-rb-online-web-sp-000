WIN_COMBINATIONS = [
  [0,1,2],  #Top row
  [3,4,5],  #Middle row
  [6,7,8],  #Bottom row
  [0,3,6],  #Left column
  [1,4,7],  #Middle column
  [2,5,8],  #Right column
  [0,4,8],  #Diagonal TL-BR
  [6,4,2]   #Diagonal BL-TR
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(input)
  input.to_i - 1
end


def play(board)
  until over?(board) == true
    turn(board)
  end
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
    elsif draw?(board)
      puts "Cat's Game!"
  end
end


def move(board, index, character)
    board[index] = character
end


def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end


def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0, 8)
    return true
  elsif position_taken?(board, index)
    return false
  elsif index < 0 || index > 8
    return false
  end
end


def turn_count(board)
  turns = 0
  board.each do |space|
    if space == "X" || space == "O"
      turns += 1
    end
  end
  return turns
end


def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    character = current_player(board)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end


def won?(board)
  WIN_COMBINATIONS.each {|win_combo|
      index_0 = win_combo[0]
      index_1 = win_combo[1]
      index_2 = win_combo[2]

      position_1 = board[index_0]
      position_2 = board[index_1]
      position_3 = board[index_2]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
           return win_combo
     elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
          return win_combo
        end
      }
  return false
end


def full?(board)
  !board.include?(" ")
end


def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end
end


def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end


def winner(board)
  index = []
  index = won?(board)
  if index == false
    return nil
  else
    if board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end
