require './middleware/static'
require './rack_app'

RSpec.describe Middleware::Static, 'test' do
  let(:app) { ->(_) { [200, {}, []] } }
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
  subject { Middleware::Static.new(app) }

  it 'checks static file is returned' do
    response = subject.call(env)

    expect(response[0]).to eq(200)
    expect(response[1]['Content-Type']).to eq('image/jpeg')
  end

  it 'returns root page' do
    response = subject.call(env_root)

    expect(response[0]).to eq(200)
    expect(response[1]).to eq({})
  end
end
