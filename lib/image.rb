class Image
  # Mandatory named arguments! Ruby 2.1 goodness
  def initialize(columns:, rows:)
    if [columns, rows].any? { |dimension|
      dimension > 250 || dimension < 1
    } # braces make clear this is not the end of the if
      raise(ArgumentError, "Rows & columns must be" +
                           "between 1 and 250 inclusive")
    end
    @image = [[:O] * columns ] * rows
  end

  def clear
    @image.each do |row|
      row.map! do |pixel|
        :O
      end
    end
  end

  def to_s
    @image.map{|row| row.join}.join("\n")
  end
end
