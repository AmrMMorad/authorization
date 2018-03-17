class Action < Sequel::Model
	one_to_one :role
	one_to_one :resource
end