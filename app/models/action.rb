class Action < Sequel::Model
	one_to_many :roles
end