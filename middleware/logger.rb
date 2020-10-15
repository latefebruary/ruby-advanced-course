require 'rack'
require 'logger'

class Middleware
  class Logger
    def initialize(app)
      @app = app
      @logger = ::Logger.new($stdout)
      @logger.level = ::Logger::INFO
    end

    def call(env)
      start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :microsecond)
      response = @app.call(env)
      end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :microsecond)
      evaluation_time_in_ms = (end_time - start_time) / 1000

      @logger.info("Request time (ms): #{evaluation_time_in_ms}")
      @logger.info("Requested path: #{env['OLD_PATH_INFO']}") if response[0] == 404

      response
    end
  end
end
