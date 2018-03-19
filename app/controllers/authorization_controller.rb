require 'sinatra/base'
require 'bcrypt'
require 'json'
require 'jwt'
# require the helpers
require './lib/sinatra/password_authorization_helper'
require './lib/sinatra/jwt_authorization_helper'

# password is hashed in the database. we cannot put it as plain text
class AuthorizationController < Sinatra::Base
	helpers Sinatra::PasswordAuthorizationHelper
	helpers Sinatra::JWTAuthorizationHelper
	
	post '/login' do
		user = User.find(email: params[:email])
	    if user && test_password(params[:password], user.password)
			content_type :json
			{ token: encode(user.email) }.to_json
		else
	    	halt 401
		end
	end

	post '/authorize' do
		user_email = decode(params[:token]).first["email"]
		user = User.find(email: user_email)
		if (user.can_access?(params[:role], params[:action], params[:resource]))
			halt 200
		else
			halt 401
		end
	end

end