require 'sinatra/base'
require './lib/sinatra/authorization_helper'
require 'bcrypt'
require 'json'
require 'jwt'

# password is hashed in the database. we cannot put it as plain text
class AuthorizationController < Sinatra::Base
	helpers Sinatra::AuthorizationHelper

	post '/login' do
		user = User.find(email: params[:email])
	    if user && test_password(params[:password], user.password)
			content_type :json
			{ token: token(user.email) }.to_json
		else
	    	halt 401
		end
	end

	post '/authorize' do
		user = User.find(email: params[:email])
		puts user.can_access?(params[:role], params[:action], params[:resource])
		# if(user.can_access?)
		# 	puts "lllllllllllllllllll"
		# if(user.has_role?(Role.find(name: params[:role])))
			# print "dsdsssssssssssssssssssssssss"
		# else
		# 	halt 401
		# end
	end

	def token email
		JWT.encode payload(email), 'HS256'
	end

	def payload email
		{
			exp: Time.now.to_i + 60 * 60,
			iat: Time.now.to_i,
			scopes: ['authorize'],
			user: {
				email: email
			}
		}
	end

end