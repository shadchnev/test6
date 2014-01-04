describe 'terminal paint' do
  xit 'should confirm to first example in the spec' do 
    STDIN.should_receive(:read).and_return("I 5 6", "L 2 3 A", "")
    STDOUT.should_receive(:puts).with("OOOOO" +
                                      "OOOOO" +
                                      "OAOOO" +
                                      "OOOOO" +
                                      "OOOOO" +
                                      "OOOOO")
  end
end
