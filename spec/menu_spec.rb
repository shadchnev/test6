require 'menu'

describe Menu do
  context 'image does not already exist' do
    it 'I M N should call Image.new' do
      expect(Image).to receive(:new).with(columns: 5, rows: 643)
      menu = Menu.new
      menu.process("I 5 643")
    end

    it 'image manipulation should show error' do
      expect(STDOUT).to receive(:puts).with("No image exists")
      menu = Menu.new
      menu.process("C")
    end
  end

  before(:each) do
    @menu = Menu.new
    @menu.instance_variable_set(:@image, Image.new(columns: 5, rows: 5))
  end

  context 'image exists' do
    it 'C should call @image.clear' do
      expect(@menu.image).to receive(:clear)
      @menu.process("C")
    end
 
    it 'L X Y C should call @image.colour_pixel with args' do
      expect(@menu.image).to receive(:colour_pixel)
      .with(column: 5, row: 6, colour: :A)
      # NB user input is 1-indexed, all internal operations are 0-indexed
      @menu.process("L 6 7 A")
    end

    it 'V X Y1 Y2 C should call @image.vertical_segment with args' do
      expect(@menu.image).to receive(:vertical_segment)
      .with(column: 5, startrow: 6, endrow: 7, colour: :A)
      @menu.process("V 6 7 8 A")
    end

    it 'H X1 X2 Y C should call @image.horizontal_segment with args' do
      expect(@menu.image).to receive(:horizontal_segment)
      .with(startcolumn: 5, endcolumn: 6, row: 7, colour: :A)
      @menu.process("H 6 7 8 A")
    end

    it 'F X Y C should call @image.fill with args' do
      expect(@menu.image).to receive(:fill)
      .with(column: 5, row: 6, colour: :A)
      @menu.process("F 6 7 A")
    end

    it 'S should puts @image' do
      expect(STDOUT).to receive(:puts)
      @menu.process("S")
    end

    it 'should not recognise I 5' do
      expect(STDOUT).to receive(:puts).with("Unrecognised command")
      @menu.process("I 5")
    end
    
    it 'should not recognise I 5 6 7' do
      expect(STDOUT).to receive(:puts).with("Unrecognised command")
      @menu.process("I 5 6 7")
    end

    it 'should not recognise I hi' do
      expect(STDOUT).to receive(:puts).with("Unrecognised command")
      @menu.process("I hi")
    end
  end
end
