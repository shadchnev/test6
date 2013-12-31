require 'image'

describe Image do
  it 'should create an image with 20 columns and 10 rows' do
    image = Image.new(columns: 20, rows: 10)
    expect(image.to_s.split(/\n/).first.length).to eq 20
    expect(image.to_s.split(/\n/).length).to eq 10
  end
end
