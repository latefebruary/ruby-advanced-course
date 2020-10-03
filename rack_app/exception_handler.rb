require 'rack'

class RackApp
  class ExceptionHandler
    STATUS_CODES = [404, 500].freeze

    def initialize(app)
      @app = app
      @file_server = Rack::Files.new(Dir.pwd)
    end

    def call(env)
      response = @app.call(env)
      code = response[0]

      if STATUS_CODES.include? code
        env.merge!('OLD_PATH_INFO' => env['PATH_INFO'])
        env.merge!('PATH_INFO' => "/public/#{code}.html")
        response = @file_server.call(env)
        response[0] = code
      end

      response
    end
  end
end
