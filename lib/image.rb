class Image

  MAX_SIZE = 250

  # Mandatory named arguments! Ruby 2.1 goodness
  def initialize(columns:, rows:)
    validate_dimension(columns: columns, rows: rows)
    @image = Array.new(columns){Array.new(rows, :O)}
  end

  def clear
    @image.each do |col|
      col.map! do |pixel|
        :O
      end
    end
  end

  def colour_pixel(column:, row:, colour:)
    validate_coords(column:column, row:row)
    validate_colour(colour:colour)
    @image[column][row] = colour
  end

  def vertical_segment(column:, startrow:, endrow:, colour:)
    (startrow..endrow).each do |row|
      colour_pixel(column: column, row: row, colour: colour)
    end
  end

  def horizontal_segment(startcolumn:, endcolumn:, row:, colour:)
    (startcolumn..endcolumn).each do |column|
      colour_pixel(column: column, row: row, colour: colour)
    end
  end

  def fill(column:, row:, colour:)
    validate_coords(column: column, row: row)
    validate_colour(colour: colour)
    orig = @image[column][row]
    edges = [[column, row]]
    while !edges.empty?
      fill_from_last(edges: edges, orig_colour: orig, final_colour: colour)
    end
  end

  def to_s
    @image.transpose.map{|row| row.join}.join("\n")
  end

  private
  def fill_from_last(edges:, orig_colour:, final_colour:)
    col, row = *edges.pop
    if in_grid?(column:col, row:row) && @image[col][row] == orig_colour
      @image[col][row] = final_colour
      # add all neighbours of the candidate to edges
      [[0,1], [1,0], [0,-1], [-1,0]].each do |offset|
        edges << [col + offset[0], row + offset[1]]
      end
    end
  end

  def validate_colour(colour:)
    unless colour =~ /^[A-Z]$/
      raise(ArgumentError, "Invalid colour") 
    end
  end

  def validate_coords(column:, row:)
    unless in_grid?(column:column, row:row)
      raise(ArgumentError, "Given co-ordinates "\
        "(#{column}, #{row}), but image size is "\
        "only #{@image.length} x #{@image[0].length}")
    end
  end
  
  def validate_dimension(columns:, rows:)
    # use constants, not magic numbers (250)
    if [columns, rows].any? { |dimension| !(1..MAX_SIZE).include? dimension }
      raise(ArgumentError, "Rows & columns must be "\
                           "between 1 and #{MAX_SIZE} inclusive")
    end
  end


  def in_grid?(column:, row:)
    begin
      @image.fetch(column).fetch(row)
    rescue IndexError
      return false
    end
    true
  end

end
