class Resource < Sequel::Model
	one_to_one :action
end