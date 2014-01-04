require 'image'

describe 'Image#clear' do
  it 'should set all pixels to :O' do
    image = Image.new(columns: 2, rows: 2)
    image.instance_variable_set(:@image, 
                                [[:A, :C],
                                 [:O, :F]])
    expect{image.clear}
    .to change{image.to_s}
    .from("AO\nCF")
    .to("OO\nOO")
  end
end
