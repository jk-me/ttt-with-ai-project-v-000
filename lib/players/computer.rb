class Players
  class Computer < Player
    attr_accessor :selfwin, :blockwin
    
    def move(board)
      if board.valid_move?('5')==TRUE
        return '5'
      elsif board.turn_count < 2
        x=['1','3','7','9'].sample until board.valid_move?(x)
        x
      else
        selfwins=[]
        blockwins=[]
        other=['X','O']-[self.token]
        g=Game::WIN_COMBINATIONS
                                    #win check
          g.each{|combo|       
            if combo.select{|n| board.cells[n]==self.token}.length==2 and combo.select{|n| board.valid_move?("#{n+1}")}.length==1
            selfwin= combo
            end
          }
          if selfwins!=[]
            n=selfwins.select{|n| board.valid_move?("#{n+1}")}
            puts "nwin is #{n}"
            return "#{n[0]+1}" if n!=[]
          end
                                    #block check
          g.each{|combo|        
            if combo.select{|n| board.cells[n]==other[0]}.length==2 and combo.select{|n| board.valid_move?("#{n+1}")}.length==1
            blockwin= combo
            end
          }
          if blockwin!=[]
            n=blockwin.select{|n| board.valid_move?("#{n+1}")}
            puts "nblock is #{n}"
            return "#{n[0]+1}" if n!=[]
          end

          x=rand(9)+1 until board.valid_move?(x)
          return "#{x}"
      end
    end
  end
end
