class Players 
  class Computer < Player
    def move(board)
      # x=rand(9)+1 until board.valid_move?(x)
      # "#{x}"
      if board.valid_move?('5')==TRUE
        return '5'
        puts "pie"
      elsif board.turn_count<3
        x=['1','3','7','9'].sample until board.valid_move?(x)
      else 
        g=Game::WIN_COMBINATIONS
        other=['X','O']-[self.token]
        selfwin=nil 
        blockwin=nil
        #if win check 
          g.each{|combo| 
            if combo.select{|n| board.cells[n]==self.token}.length==2
            selfwin=combo 
            end}
          if selfwin!=[]
            return selfwin.select{|n| board.valid_move?(n)} 
          end
        #elsif block check 
          g.each{|combo| 
            if combo.select{|n| board.cells[n]==other[0]}.length==2
            blockwin=combo 
            end}
          return blockwin.select{|n| board.valid_move?(n)} if blockwin!=[]
        #else 
          x=rand(9)+1 until board.valid_move?(x)
          return "#{x}"
        #end 
      end
    end
  end
end
