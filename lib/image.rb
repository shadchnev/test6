class Image
  # Mandatory named arguments! Ruby 2.1 goodness
  def initialize(columns:, rows:)
    @image = [[:O] * columns ] * rows
  end

  def to_s
    @image.map{|row| row.join}.join("\n")
  end
end
