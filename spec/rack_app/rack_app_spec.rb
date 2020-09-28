require './rack_app/rack_app'

RSpec.describe RackApp, 'test' do
  subject { described_class.new }

  it 'checks rack_app response is valid' do
    response = subject.call('')

    expect(response.size).to eq(3)
    expect(response).to be_a(Array)
    expect(response[0]).to be_a(Integer)
    expect(response[1]).to be_a(Hash)
    expect(response[2]).to be_a(Enumerable)
  end

  it 'checks rack_app returns hello world' do
    response = subject.call('')

    expect(response[2].first).to eq('Hello world')
  end
end
