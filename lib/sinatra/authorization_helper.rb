require 'sinatra/base'
require 'bcrypt'

module Sinatra
	module AuthorizationHelper
		def hash_password(password)
			BCrypt::Password.create(password).to_s
		end

		def test_password(password, hash)
			BCrypt::Password.new(hash) == password
		end
	end
	
	helpers AuthorizationHelper
end

