require 'rubygems'
require 'sinatra'
require 'logger'
require 'prawn'
require 'prawn/layout'
require 'yaml'
require 'dm-core'
require 'haml'
require 'sass'

# Configuration ==========================================================
APP_NAME      = "coaching"
SINATRA_ROOT  = File.expand_path("#{ENV['HOME']}/#{APP_NAME}/app")
ENVIRONMENT   = Sinatra::Application.environment

# Configuration ==========================================================
configure do
  LOGGER = Logger.new("#{SINATRA_ROOT}/log/sinatra.log")
end

# Include Sinatra root directory in the application's load path
$LOAD_PATH.unshift SINATRA_ROOT

# Helpers ================================================================
load "helpers/helpers.rb"

# Load application configuration
load "config/default.config.rb"