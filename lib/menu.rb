require_relative 'image'

class Menu
  attr_reader :image
  
  def show_menu()
    system('clear')
    loop do
      print '> '
      process_input(STDIN.gets.chomp)
    end
  end
  
  def process_input(selection)
    begin
      case selection
      when /^I\s+\d+\s+\d+$/
        cols, rows = *selection.split[1..2].map(&:to_i)
        @image = Image.new(columns: cols, rows: rows)
      when /^C$/
        @image.clear
      when /^L\s+\d+\s+\d+\s+[A-Z]$/
        column, row = *selection.split[1..2].map(&:to_i)
        colour = selection.split[3].to_sym
        # All operations in image.rb are zero-indexed, so need to convert
        @image.colour_pixel(column: column - 1, 
                            row: row - 1,
                            colour: colour)
      when /^V\s+\d+\s+\d+\s+\d+\s+[A-Z]$/
        column, startrow, endrow = *selection.split[1..3].map(&:to_i)
        colour = selection.split[4].to_sym
        @image.vertical_segment(column: column - 1,
                                startrow: startrow - 1,
                                endrow: endrow - 1,
                                colour: colour)
      when /^H\s+\d+\s+\d+\s+\d+\s+[A-Z]$/
        startcolumn, endcolumn, row = *selection.split[1..3].map(&:to_i)
        colour = selection.split[4].to_sym
        @image.horizontal_segment(startcolumn: startcolumn - 1,
                                  endcolumn: endcolumn - 1,
                                  row: row - 1,
                                  colour: colour)
      when /^F\s+\d+\s+\d+\s+[A-Z]$/
        column, row = *selection.split[1..2].map(&:to_i)
        colour = selection.split[3].to_sym
        @image.fill(column: column - 1,
                    row: row - 1,
                    colour: colour)
      when /^S$/
        # nil has a to_s method, so need to manually raise
        # if there's no image
        raise NoMethodError unless @image
        puts @image.to_s
      when /^X$/
        exit
      else
        puts 'Unrecognised command'
      end
    rescue ArgumentError => e
      puts e.message
    rescue NoMethodError
      puts 'No image exists'
    end
    
  end
end
