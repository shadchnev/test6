require 'image'

describe 'Image#segment' do
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
end
