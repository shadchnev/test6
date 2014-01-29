require 'menu'

describe 'terminal paint' do
  before(:each) do
    @menu = Menu.new
  end

  # That's a good thing: writing tests for the examples given to you.
  # Some candidates fail because their code doesn't pass the examples provided
  it 'should confirm to first example in the spec' do 
    @menu.process("I 5 6")
    @menu.process("L 2 3 A")
    expect(STDOUT).to receive(:puts).with("OOOOO\n" +
                                          "OOOOO\n" +
                                          "OAOOO\n" +
                                          "OOOOO\n" +
                                          "OOOOO\n" +
                                          "OOOOO")
    @menu.process("S")
  end
  
  it 'should confirm to second example in the spec' do 
    @menu.process("I 5 6")
    @menu.process("L 2 3 A")
    @menu.process("F 3 3 J")
    @menu.process("V 2 3 4 W")
    @menu.process("H 3 4 2 Z")
    expect(STDOUT).to receive(:puts).with("JJJJJ\n" +
                                          "JJZZJ\n" +
                                          "JWJJJ\n" +
                                          "JWJJJ\n" +
                                          "JJJJJ\n" +
                                          "JJJJJ")
    @menu.process("S")
  end
 end
