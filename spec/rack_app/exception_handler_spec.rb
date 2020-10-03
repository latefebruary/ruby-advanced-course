require './rack_app/exception_handler'
require './rack_app'

RSpec.describe RackApp::ExceptionHandler, 'test' do
  let(:app) { RackApp.new }
  let(:static) { RackApp::Static.new(app) }
  let(:env) do
    {
      'PATH_INFO' => '/some_wrong_path',
      'REQUEST_METHOD' => 'GET'
    }
  end
  let(:env_root) do
    {
      'PATH_INFO' => '/',
      'REQUEST_METHOD' => 'GET'
    }
  end
  subject { RackApp::ExceptionHandler.new(static) }

  it 'renders 404 page' do
    response = subject.call(env)

    expect(response[0]).to eq(404)
    expect(response[1]['Content-Type']).to eq('text/html')
  end

  it 'returns root page' do
    response = subject.call(env_root)

    expect(response[0]).to eq(200)
    expect(response[2]).to eq(['Hello world'])
  end
end
