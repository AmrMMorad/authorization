class User < Sequel::Model
	many_to_many :roles

	def get_role(role_name)
		self.roles.find(name: role_name).first
	end

	def has_action_to_resource?(role, action_name, resource_name)
		role.action.name == action_name && role.resource.name == resource_name
	end

	def can_access?(role_name, action_name, resource_name)
		role = get_role(role_name)
		has_action_to_resource?(role, action_name, resource_name)
	end
end