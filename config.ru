require 'rubygems'
require 'bundler'

Bundler.require

Dir[File.join(File.dirname(__FILE__), '..',  'app', '**/*.rb')].sort.each do |file|
  require file
end

run authorization