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

  def to_s
    @image.map{|row| row.join}.join("\n")
  end

  private
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
