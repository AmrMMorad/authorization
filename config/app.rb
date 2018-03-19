require 'sinatra/base'
require 'sinatra/sequel'
require 'yaml'
require 'sequel/extensions/seed'
require "sinatra/config_file"

class App < Sinatra::Base
	register Sinatra::SequelExtension
	register Sinatra::ConfigFile

	configure do
		config_file "config.yml"
		# set :database, database.yml
		config = YAML::load_file("config/database.yml")["development"]
		DB = Sequel.connect(config)
	end

	# load all the models and controllers files
	Dir[File.join(File.dirname(__FILE__), '..', 'app', '**/*.rb')].sort.each do |file|
		require file
	end

	#run seeds
  	Sequel::Seed.setup(:development)
	Sequel.extension :seed
	Sequel::Seeder.apply(DB, "db/seeds")

end