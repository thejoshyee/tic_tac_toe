require 'pry-byebug'

class TicTacToe
    def initialize
        # Game Board & start game
        puts "Welcome to Tic Tac Toe!"
        @board = [" "," "," "," "," "," "," "," "," "]
        play(@board)
    end

    # Winning Combos array
    WIN_COMBINATIONS = [
        [0,1,2], 
        [3,4,5],  
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    # Display game board
    def display_board(board)
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    # Define players moves and convert them to integer
    def input_to_index(user_input)
        user_input.to_i - 1
    end

    # player_move should include current_player(board) so it displays X or O
    def player_move(board, index, marker)
        board[index] = marker
    end

    # conditions to check if position is taken and if valid move
    def position_taken? (board, index)
        if @board[index] == "" || @board[index] == " " || @board[index] == nil
            return false
        else
            return true
        end
    end

    def valid_move?(board, index) 
        #if position is not taken and index is between 0-8 then return true to check if valid
        if !position_taken?(@board, index) && (index).between?(0,8)
            return true
        else
            return false
        end
    end

    #ask for players inputs and keep track of turns and player markers
    def current_player(board)
        #is turn count divisible by 2 then return X, if not, return O. 
        turn_count(@board) % 2 == 0? "X" : "O"
    end

    def turn(board)
        puts "Please enter 1-9:"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(@board, index)
            player_move(@board, index, current_player(@board))
            display_board(@board)
        else
            turn(@board)
        end
    end

    def turn_count(board)
        counter = 0
        @board.each { |space| 
            if space == "X" || space == "O"
                counter += 1
            end
        }
        counter
    end

    # Check for winning combos
    def won?(board)
        WIN_COMBINATIONS.each do |single_win_combo|
            win_index_1 = single_win_combo[0]
            win_index_2 = single_win_combo[1]
            win_index_3 = single_win_combo[2]

            # Pos 1,2,3 will cycle thru all 9 spaces on board
            position_1 = board[win_index_1]
            position_2 = board[win_index_2]
            position_3 = board[win_index_3]

            if position_1 == position_2 && position_2 == position_3 && position_taken?(@board, win_index_1)
                return single_win_combo
            end
        end
        return false
    end

    # Check if board is full
    def full?(board)
        if @board.any? {|index| index == nil || index == " "}
            return false
        else
            return true
        end
    end

    # Check if draw
    def draw?(board)
        if !won?(@board) && full?(@board)
            return true
        elsif!full?(@board) && !won?(@board)
            return false
        else won?(@board)
            return false
        end
    end

    # Check if game over
    def over?(board)
        if draw?(@board) || won?(@board) || full?(@board)
            return true
        else
            return false
        end
    end

    # Game Play and Winner Announcement 

    def winner(board)
        if won?(@board)
            return @board[won?(@board)[0]]
        end
    end

    #play the game - if counter is at 9 then all the spaces are filled other wise take turns
    def play(board)
        counter = 0
        until counter == 9
            turn(@board)
            counter += 1
        end
    end

    def play(board)
        until over?(@board)
            turn(@board)
        end
        if won?(@board)
            winner(@board) == "X" || winner(@board) == "O"
            puts "Congrats #{winner(@board)}!"
        else draw?(@board)
            puts "Cat's Game!"
        end
    end
end

# Start the Game
game = TicTacToe.new
