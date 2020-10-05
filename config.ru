require 'rubygems'
require 'bundler'
Bundler.require

require './rack_app'
require './middleware/static'
require './middleware/exception_handler'
require './middleware/logger'
require './middleware/show_errors'

use Rack::Reloader
use Middleware::Logger
use Middleware::ShowErrors
use Middleware::ExceptionHandler
use Middleware::Static
run RackApp.new
