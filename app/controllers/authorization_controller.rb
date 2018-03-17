require 'sinatra/base'
require './lib/sinatra/authorization_helper'
require 'bcrypt'

# password is hashed in the database. we cannot put it as plain text
class AuthorizationController < Sinatra::Base
	helpers Sinatra::AuthorizationHelper

	post '/login' do
		user = User.find(email: params[:email])
		puts user.email
	    if user && test_password(params[:password], user.password)
	    	status 200
	    	puts "success"
	    else
	    	puts "NNNNN"
		end
	end
end