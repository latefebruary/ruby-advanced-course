require './rack_app/static'
require './rack_app'

RSpec.describe RackApp::Static, 'test' do
  let(:app) { RackApp.new }
  let(:env) do
    {
      'PATH_INFO' => '/public/EHdvu.jpeg',
      'REQUEST_METHOD' => 'GET'
    }
  end
  let(:env_root) do
    {
      'PATH_INFO' => '/',
      'REQUEST_METHOD' => 'GET'
    }
  end
  subject { RackApp::Static.new(app) }

  it 'checks static file is returned' do
    response = subject.call(env)

    expect(response[0]).to eq(200)
    expect(response[1]['Content-Type']).to eq('image/jpeg')
  end

  it 'returns root page' do
    response = subject.call(env_root)

    expect(response[0]).to eq(200)
    expect(response[1]).to eq({})
    expect(response[2]).to eq(['Hello world'])
  end
end
