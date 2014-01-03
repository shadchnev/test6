require 'image'

describe Image do
  it 'should create an image with 20 columns and 10 rows' do
    image = Image.new(columns: 20, rows: 10)
    expect(image.to_s.split(/\n/).first.length).to eq 20
    expect(image.to_s.split(/\n/).length).to eq 10
  end

  context 'size limits' do
    it 'should have a maximum size of 250 in each dimension' do
      expect(Image.new(columns: 250, rows: 250)).to_not be_nil
    end
  end
end
