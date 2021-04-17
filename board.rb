
class Board 
  attr_reader :size 

  def initialize(size = 4) 
    @grid = Array.new(size) { Array.new(size) } 
    @size = size 
  end 

  def [](pos) 
    row, col = pos 
    grid[row][col] 
  end 

  def []=(pos, value) 
    row, col = pos  
    grid[row][col] = value 
  end 

  def hide(pos) 
    self[pos].hide 
  end 

  def reveal(pos) 
    if revealed?(pos) 
      puts "can not flip a card that has revealed"
    else 
      self[pos].reveal
    end 
    self[pos].value 
  end 

  def populate 
    num_pairs = (size**2) / 2 
    cards  Card.shuffled_pairs(num_pairs) 
    grid.each_index do |i| 
      grid.each_index do |j|  
        self[i][j] == cards.pop 
      end 
    end 
  end 

  def render 
    system("clear") 
    puts " #{(0...size).to_a.join(' ')}" 
    grid.each_with_index do |row, i| 
      puts "#{i} #{row.join(' ')}" 
    end 
  end 

  def revealed?(pos) 
    self[pos].revealed? 
  end 

  def won?
    grid.all? do |row| 
      row.all?(&:revealed?) 
    end 
  end 

  private 

  attr_reader :grid 
end 

  def 