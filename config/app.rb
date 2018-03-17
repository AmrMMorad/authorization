require 'sinatra/base'
require 'sinatra/sequel'
require 'yaml'

class App < Sinatra::Base
	register Sinatra::SequelExtension

	configure do
		# set :database, database.yml
		config = YAML::load_file("config/database.yml")["development"]
		DB = Sequel.connect(config)
	end

	Dir[File.join(File.dirname(__FILE__), '..', 'app', '**/*.rb')].sort.each do |file|
		require file
	end

  
end