describe 'terminal paint' do
  it 'should display a chevron when first run' do
    STDOUT.should_receive(:puts).with(">")
    load 'paint.rb'
  end
end
