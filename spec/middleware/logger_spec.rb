require './middleware/logger'
require './rack_app'

RSpec.describe Middleware::Logger, 'test' do
  let(:app) { ->(_) { [200, {}, []] } }
  let(:env) do
    {
      'PATH_INFO' => '/',
      'REQUEST_METHOD' => 'GET'
    }
  end

  subject { Middleware::Logger.new(app) }

  it 'logs req calculated time to stdout' do
    expect { subject.call(env) }.to output(/Request time/).to_stdout
  end
end
