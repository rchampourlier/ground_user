require 'mongoid'

env = ENV['APP_ENV']
raise 'APP_ENV environment variable must be set' if env.nil?

ENV['MONGOID_ENV'] = env
puts "Loading MongoDB in #{env} (#{ENV['MONGODB_URI']})"
Mongoid.load! File.expand_path('../mongoid.yml', __FILE__)
