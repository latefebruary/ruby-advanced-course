require 'rubygems'
require 'bundler'
Bundler.require

require './rack_app/rack_app'

run RackApp.new
