require 'rubygems'
require 'bundler'
Bundler.require

require './rack_app'
require './rack_app/static'
require './rack_app/exception_handler'
require './rack_app/logger'

use Rack::Reloader
use RackApp::Logger
use RackApp::ExceptionHandler
use RackApp::Static
run RackApp.new
