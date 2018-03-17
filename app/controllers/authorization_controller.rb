require 'sinatra/base'

class AuthorizationController < Sinatra::Base
	
	post '/login' do
		puts params[:username]
	end
end