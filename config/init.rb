require "bundler"
require "fileutils"

# Set the environment
env = (ENV["RACK_ENV"] || :development).to_sym

# Load all bundled dependencies
Bundler.require(:default, env)
require "sinatra/reloader" if development?

require_all "app"
