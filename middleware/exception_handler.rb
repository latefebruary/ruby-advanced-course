require 'rack'

class Middleware
  class ExceptionHandler
    STATUS_CODES = [404, 500].freeze

    def initialize(app)
      @app = app
      @logger = ::Logger.new($stdout)
    end

    def call(env)
      @app.call(env)
    rescue StandardError => e
      @logger.error(env['PATH_INFO'])
      @logger.error(e.inspect)
      [500, {}, []]
    end
  end
end
