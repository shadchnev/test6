require 'image'

describe 'Image#clear' do
  it 'should set all pixels to :O' do
    image = Image.new(columns: 4, rows: 2)
    image.instance_variable_set(:@image, 
                                [[:A, :B, :C, :D],
                                 [:O, :P, :Q, :R]])
    expect{image.clear}
    .to change{image.to_s}
    .from("ABCD\nOPQR")
    .to("OOOO\nOOOO")
  end
end
