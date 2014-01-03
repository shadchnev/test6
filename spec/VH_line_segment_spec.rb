require 'image'

describe 'Image#vertical_segment, Image#horizontal_segment' do
  let(:image){Image.new(columns: 5, rows: 5)}

  it 'should draw a vertical segment' do
    expect{image.vertical_segment(column: 2,
                                  startrow: 1,
                                  endrow: 3,
                                  colour: :A)}
    .to change{image.to_s}
    .from("OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO")
    .to("OOOOO\nOOAOO\nOOAOO\nOOAOO\nOOOOO")
  end
  
  it 'should draw a horizontal segment' do
    expect{image.horizontal_segment(startcolumn: 1,
                                    endcolumn: 3,
                                    row: 2,
                                    colour: :A)}
    .to change{image.to_s}
    .from("OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO")
    .to("OOOOO\nOOOOO\nOAAAO\nOOOOO\nOOOOO")
  end

  it 'should raise an error if any coords are out of bounds' do
    # validation done by colour_pixel, see L_colourpixel_spec
  end
end

