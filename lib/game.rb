class Game
  attr_accessor :board, :player_1, :player_2
  WIN_COMBINATIONS=[
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]]
    
  def initialize(p1=Players::Human.new('X'), p2=Players::Human.new('O'), board=Board.new )
    @board=board
    @player_1 = p1 
    @player_2 = p2 
  end
  
  def current_player 
    self.board.turn_count.odd? ? @player_2 : @player_1
  end
  
  def won?
    WIN_COMBINATIONS.each do |combo|
      if (combo.all? {|n| self.board.cells[n]=='X'}) or (combo.all?{|n| self.board.cells[n]=='O'})
        return combo
      end
    end
  return FALSE
  end

  def draw?
    (!won? && @board.full?) ? TRUE : FALSE
  end

  def over?
    won? || draw?|| @board.full? ? TRUE : FALSE
  end
  
  def winner
    won? ? self.board.cells[won?[0]] : nil
  end

  def turn
    puts "Please enter 1-9:"
    board.display
    i=self.current_player.move(self.board) 
     if self.board.valid_move?(i) 
       self.board.update(i,self.current_player) 
     else 
       puts 'invalid' 
       self.turn 
     end 
  end
  
  def play
    while !over?
      turn
    end
    if draw?
      puts "Cat's Game!"
    else
      w=winner
      puts "Congratulations #{w}!"
    end
  end
  
  def self.start 
    compx=Players::Computer.new('X')
    compo=Players::Computer.new('O')
    humx=Players::Human.new('X')
    humo=Players::Human.new('O')
    b=Board.new

    puts 'Hi tictactoe'
    puts 'Enter number of players: (0,1,2)'
    x=gets.strip.to_i
    if x==0
      g=Game.new(compx,compo,b)
      g.play
    elsif x==1
      puts "Who will play first (as X)? 'computer' or 'human'?"
      x=gets.strip
      if x=='computer'
        g=Game.new(compx,humo,b)
        g.play
      elsif x=='human'
        g=Game.new(humx,compo,b)
        g.play
      else 
        puts 'invalid input, exiting'
      end
    else x==2
      g=Game.new
      g.play
    end
    puts "Enter 'y' to play again or any other key to exit."
    x=gets.strip
    if x=='y'
      Game.start
    else 
      exit
    end
  end

end
