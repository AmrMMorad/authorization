class Role < Sequel::Model
	many_to_many :users
	many_to_one :action
	many_to_one :resource
end