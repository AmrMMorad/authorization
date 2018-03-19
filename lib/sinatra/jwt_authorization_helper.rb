require 'sinatra/base'
require 'bcrypt'

# HMAC algorithm will be used for the token
# The secret key is better to be stored in environment variables of the server
# instead of putting it as a configuration in the config file
# The key is generated randomly using simple Java program which consists of 32 characters
module Sinatra
	module JWTAuthorizationHelper

		def encode(email)
			JWT.encode payload(email), App.settings.secret_key, App.settings.algorithm
		end

		def decode(jwt_token)
			begin
				JWT.decode jwt_token, App.settings.secret_key, true, { algorithm: App.settings.algorithm }
			rescue
				halt 401
			end
		end

		# here we can add more parameters for the payload, if needed
		def payload(email)
			{
				email: email
			}
		end
	end
	
	helpers JWTAuthorizationHelper
end

