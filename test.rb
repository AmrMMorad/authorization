# app.rb
require 'sinatra'

class Test < Sinatra::Base
  get '/' do
    "Hello, world!"
  end
end