require './middleware/exception_handler'
require './rack_app'

RSpec.describe Middleware::ExceptionHandler, 'test' do
  let(:app) { ->(_) { raise } }
  let(:env) { { 'PATH_INFO' => '/some_wrong_path' } }

  subject { Middleware::ExceptionHandler.new(app) }

  it 'rescues exception and returns 500' do
    response = subject.call(env)

    expect(response[0]).to eq(500)
    expect(response[1]).to eq({})
  end
end
