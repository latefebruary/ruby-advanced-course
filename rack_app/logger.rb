require 'rack'
require 'logger'

class RackApp
  class Logger
    def initialize(app)
      @app = app
    end

    def call(env)
      logger = ::Logger.new($stdout)
      logger.level = ::Logger::INFO

      logger.info("Request started: #{Time.now}")
      response = @app.call(env)
      logger.info("Request finished: #{Time.now}")
      logger.info("Requested path: #{env['OLD_PATH_INFO']}") if response[0] == 404

      response
    end
  end
end
