# Load dependencies
require 'rubygems'
require 'bundler/setup'
require 'dotenv'
Dotenv.load
#env = ENV['APP_ENV'] || 'development'

root_dir = File.expand_path '../..', __FILE__
$LOAD_PATH.unshift root_dir
require 'config/mongo'
require 'lib/ground_user'
$LOAD_PATH.shift
