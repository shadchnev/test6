require 'image'

describe Image do
  it 'should create an image with 20 columns and 10 rows' do
    image = Image.new(columns: 20, rows: 10)
    expect(image.to_s.split(/\n/).first.length).to eq 20
    expect(image.to_s.split(/\n/).length).to eq 10
  end

  it 'should have a maximum size of 250 in each dimension' do
    expect{Image.new(columns: 250, rows: 250)}.not_to raise_error
    expect{Image.new(columns: 251, rows: 250)}.to raise_error(ArgumentError)
    expect{Image.new(columns: 250, rows: 251)}.to raise_error(ArgumentError)
  end

  it 'should have a minimum size of 1 in each dimension' do
    expect{Image.new(columns: 1, rows: 1)}.not_to raise_error
    expect{Image.new(columns: 1, rows: 0)}.to raise_error(ArgumentError)
    expect{Image.new(columns: 1, rows: -1)}.to raise_error(ArgumentError)
  end

  it 'should raise for non-numeric inputs' do
    expect{Image.new(columns: 'go', rows: 'fish')}.to raise_error
  end
end
