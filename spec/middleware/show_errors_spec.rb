require './middleware/show_errors'
require './rack_app'

RSpec.describe Middleware::ShowErrors, 'test' do
  let(:app_200) { ->(_) { [200, {}, []] } }
  let(:app_404) { ->(_) { [404, {}, []] } }
  let(:app_500) { ->(_) { [500, {}, []] } }
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

  context '404' do
    subject { Middleware::ShowErrors.new(app_404) }

    it 'renders 404 page' do
      response = subject.call(env)

      expect(response[0]).to eq(404)
      expect(response[1]['Content-Type']).to eq('text/html')
    end
  end

  context '500' do
    subject { Middleware::ShowErrors.new(app_500) }

    it 'renders 500 page' do
      response = subject.call(env)

      expect(response[0]).to eq(500)
      expect(response[1]['Content-Type']).to eq('text/html')
    end
  end

  context '200' do
    subject { Middleware::ShowErrors.new(app_200) }

    it 'returns normal page' do
      response = subject.call(env_root)

      expect(response[0]).to eq(200)
      expect(response[1]).to eq({})
    end
  end
end
