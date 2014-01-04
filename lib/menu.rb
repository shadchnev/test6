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
        process_I(*parse(input))
      when /^C$/
        @image.clear
      when /^L\s+\d+\s+\d+\s+[A-Z]$/
        process_L(*parse(input))
      when /^V\s+\d+\s+\d+\s+\d+\s+[A-Z]$/
        process_V(*parse(input))
      when /^H\s+\d+\s+\d+\s+\d+\s+[A-Z]$/
        process_H(*parse(input))
      when /^F\s+\d+\s+\d+\s+[A-Z]$/
        process_F(*parse(input))
      when /^S$/
        # nil#to_s exists, so need to manually raise
        raise NoMethodError unless @image
        puts @image.to_s
      when /^X$/
        exit
      else
        puts 'Unrecognised command'
      end
    rescue ArgumentError => e
      # pass argument errors up from image.rb
      puts e.message
    rescue NoMethodError
      puts 'No image exists'
    end
  end

  private
  def process_I(cols, rows)
    @image = Image.new(columns: cols, rows: rows)
  end

  def process_F(column, row, colour)
    # All operations in image.rb are zero-indexed, so need to convert
    @image.fill(column: column - 1,
                row: row - 1,
                colour: colour)
  end

  def process_H(startcolumn, endcolumn, row, colour)
    @image.horizontal_segment(startcolumn: startcolumn - 1,
                              endcolumn: endcolumn - 1,
                              row: row - 1,
                              colour: colour)
  end

  def process_V(column, startrow, endrow, colour)
    @image.vertical_segment(column: column - 1,
                            startrow: startrow - 1,
                            endrow: endrow - 1,
                            colour: colour)
  end

  def process_L(column, row, colour)
    @image.colour_pixel(column: column - 1, 
                        row: row - 1,
                        colour: colour)
  end

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
