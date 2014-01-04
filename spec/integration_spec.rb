require 'menu'

describe 'terminal paint' do
  before(:each) do
    @menu = Menu.new
  end

  it 'should confirm to first example in the spec' do 
    @menu.process_input("I 5 6")
    @menu.process_input("L 2 3 A")
    expect(STDOUT).to receive(:puts).with("OOOOO\n" +
                                          "OOOOO\n" +
                                          "OAOOO\n" +
                                          "OOOOO\n" +
                                          "OOOOO\n" +
                                          "OOOOO")
    @menu.process_input("S")
  end
  
  it 'should confirm to second example in the spec' do 
    @menu.process_input("I 5 6")
    @menu.process_input("L 2 3 A")
    @menu.process_input("F 3 3 J")
    @menu.process_input("V 2 3 4 W")
    @menu.process_input("H 3 4 2 Z")
    expect(STDOUT).to receive(:puts).with("JJJJJ\n" +
                                          "JJZZJ\n" +
                                          "JWJJJ\n" +
                                          "JWJJJ\n" +
                                          "JJJJJ\n" +
                                          "JJJJJ")
    @menu.process_input("S")
  end
 end
