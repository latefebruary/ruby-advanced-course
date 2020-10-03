require 'rack'

class RackApp
  class Static
    URL = '/public'.freeze

    def initialize(app)
      @app = app
      @file_server = Rack::Files.new(Dir.pwd)
    end

    def can_serve(path)
      path.index(URL) == 0
    end

    def call(env)
      path = env['PATH_INFO']

      if can_serve(path)
        @file_server.call(env)

      else
        @app.call(env)
      end
    end
  end
end
