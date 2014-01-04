class Image
  # Mandatory named arguments! Ruby 2.1 goodness
  def initialize(columns:, rows:)
    if [columns, rows].any? { |dimension|
      dimension > 250 || dimension < 1
    } # braces make clear this is not the end of the if
      raise(ArgumentError, "Rows & columns must be "\
                           "between 1 and 250 inclusive")
    end
    @image = Array.new(rows){Array.new(columns, :O)}
  end

  def clear
    @image.each do |row|
      row.map! do |pixel|
        :O
      end
    end
  end

  def colour_pixel(column:, row:, colour:)
    validate_coords(column:column, row:row)
    validate_colour(colour: colour)
    @image[row][column] = colour
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
    recursive_fill(edges:[[column,row]], 
                   orig_colour: @image[row][column], 
                   final_colour: colour)
  end

  def to_s
    @image.map{|row| row.join}.join("\n")
  end

  private
  def recursive_fill(edges:, orig_colour:, final_colour:)
    @count ||= 0
    @count += 1
    p @count
    return if edges.empty?
    # colour all edges the final colour
    edges.each{|col, row| @image[row][col] = final_colour} 
    # add all neighbours of edges to edges
    new_edges = []
    edges.each do |col, row|
      [[0,1], [1,0], [0,-1], [-1,0]].each do |offset|
        new_edges << [col + offset[0], row + offset[1]]
      end
    end
    # filter out pixels that are already done, or not the original
    # colour, or outside the boundaries of the image
    new_edges.select! do |col, row|
      begin
        @image[row][col] == orig_colour
      rescue NoMethodError
        # need this for if row is out of bounds, as then
        # you're calling [] on nil 
        false  
      end
    end
    recursive_fill(edges: new_edges, 
                   orig_colour: orig_colour, 
                   final_colour: final_colour)
  end

  def validate_colour(colour:)
    raise(ArgumentError, "Invalid colour") unless
      colour =~ /^[A-Z]$/
  end

  def validate_coords(column:, row:)
    begin
      @image.fetch(row).fetch(column)
    rescue IndexError
      # convert to argumenterror as that's caught &
      # shown to the user w/o quitting
      raise(ArgumentError, "Given co-ordinates "\
        "(#{column}, #{row}), but image size is "\
        "only #{@image[0].length} x #{@image.length}")
    end
  end

end
