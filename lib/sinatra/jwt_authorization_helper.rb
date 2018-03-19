require 'sinatra/base'
require 'bcrypt'

module Sinatra
	module JWTAuthorizationHelper
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
	
	helpers JWTAuthorizationHelper
end

