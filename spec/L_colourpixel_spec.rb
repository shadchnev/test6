require 'image'

describe 'Image#colour_pixel' do
  let(:image){Image.new(columns:2, rows:2)}

  it 'should colour a pixel' do
    expect{image.colour_pixel(column:0, 
                              row:0, 
                              colour: :C)}
    .to change{image.to_s}
    .from("OO\nOO")
    .to("CO\nOO")
  end

  it 'should raise an error for invalid colours' do
    expect{image.colour_pixel(column:0, 
                              row:0, 
                              colour: 7)}
    .to raise_error(ArgumentError)

    expect{image.colour_pixel(column:0, 
                              row:0, 
                              colour: :AB)}
    .to raise_error(ArgumentError)
  end

  it 'should raise an error for pixel out of bounds' do
    expect{image.colour_pixel(column:2, 
                              row:0, 
                              colour: :A)}
    .to raise_error(ArgumentError)

    expect{image.colour_pixel(column:0, 
                              row:2, 
                              colour: :A)}
    .to raise_error(ArgumentError)
  end
end
