require_relative 'image'

class Menu
  attr_reader :image
  
  def show_menu()
    system('clear')
    loop do
      print '> '
      process(STDIN.gets.chomp)
    end
  end
  
  def process(input)
    begin
      case input
      when /^I\s+\d+\s+\d+$/
        cols, rows = parse(input)
        @image = Image.new(columns: cols, rows: rows)
      when /^C$/
        @image.clear
      when /^L\s+\d+\s+\d+\s+[A-Z]$/
        column, row, colour = *parse(input)
        # All operations in image.rb are zero-indexed, so need to convert
        @image.colour_pixel(column: column - 1, 
                            row: row - 1,
                            colour: colour)
      when /^V\s+\d+\s+\d+\s+\d+\s+[A-Z]$/
        column, startrow, endrow, colour = parse(input)
        @image.vertical_segment(column: column - 1,
                                startrow: startrow - 1,
                                endrow: endrow - 1,
                                colour: colour)
      when /^H\s+\d+\s+\d+\s+\d+\s+[A-Z]$/
        startcolumn, endcolumn, row, colour = parse(input)
        @image.horizontal_segment(startcolumn: startcolumn - 1,
                                  endcolumn: endcolumn - 1,
                                  row: row - 1,
                                  colour: colour)
      when /^F\s+\d+\s+\d+\s+[A-Z]$/
        column, row, colour = parse(input)
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

  private
  def parse(input)
    params = input.split[1..-1]
    case params.length
    when 2
      params.map(&:to_i)
    when 3
      params[0..1].map(&:to_i) + [params[2].to_sym]
    when 4
      params[0..2].map(&:to_i) + [params[3].to_sym]
    end
  end
end
