class Role < Sequel::Model
	many_to_many :users
	one_to_one :action
end