require 'sinatra/base'
require 'sinatra/sequel'
require 'yaml'
require 'sequel/extensions/seed'
require './lib/sinatra/authorization_helper'

class App < Sinatra::Base
	register Sinatra::SequelExtension
	helpers Sinatra::AuthorizationHelper

	configure do
		# set :database, database.yml
		config = YAML::load_file("config/database.yml")["development"]
		DB = Sequel.connect(config)
	end

	Dir[File.join(File.dirname(__FILE__), '..', 'app', '**/*.rb')].sort.each do |file|
		require file
	end

  	Sequel::Seed.setup(:development)
	Sequel.extension :seed
	Sequel::Seeder.apply(DB, "db/seeds")

end