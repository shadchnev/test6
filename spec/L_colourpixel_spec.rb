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
end
