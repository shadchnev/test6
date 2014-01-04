require 'image'
require 'timeout'

describe 'Image#fill' do
  let(:image){Image.new(columns:3, rows:3)}

  it 'should fill a white image completely' do
    expect{image.fill(column: 0,
                      row: 0,
                      colour: :A)}
    .to change{image.to_s}
    .from("OOO\nOOO\nOOO")
    .to("AAA\nAAA\nAAA")
  end

  it 'should fill all pixels which share a common side & colour' do
    image.instance_variable_set(:@image, 
                                [[:O,:A,:B],
                                 [:A,:A,:A],
                                 [:C,:A,:D]])

    expect{image.fill(column: 1,
                      row: 1,
                      colour: :E)}
    .to change{image.to_s}
    .from("OAB\nAAA\nCAD")
    .to("OEB\nEEE\nCED")
  end

  it 'should not touch a same-coloured but unconnected pixel' do
    image.instance_variable_set(:@image, 
                                [[:O,:A,:O],
                                 [:A,:O,:A],
                                 [:O,:A,:O]])

    expect{image.fill(column: 1,
                      row: 1,
                      colour: :E)}
    .to change{image.to_s}
    .from("OAO\nAOA\nOAO")
    .to("OAO\nAEA\nOAO")
  end

  it 'should fill a 250x250 image without a problem' do
    image = Image.new(columns:250, rows:250)
    Timeout::timeout(1) do
      image.fill(column: 125,
                 row: 125,
                 colour: :A)
    end
    expect(image.to_s.count("A")).to eq 62500
  end

  it 'should raise an error if any coords are out of bounds' do
    expect{image.fill(column: 3,
                      row: 3,
                      colour: :E)}
    .to raise_error(ArgumentError)
  end

  it 'should raise an error if given an invalid colour' do
    expect{image.fill(column: 2,
                      row: 2,
                      colour: :'1')}
    .to raise_error(ArgumentError)
  end
end
