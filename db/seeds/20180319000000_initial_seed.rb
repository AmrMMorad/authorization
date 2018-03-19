require 'sequel'
require 'sequel/extensions/seed'

# Applies only to "development" and "test" environments
Sequel.seed(:development, :test) do
  def run
    user = User.create(email: "amr.morad@gmail.com", password: BCrypt::Password.create("password").to_s)
    Action.create(name: 'action1')
    Resource.create(name: 'resource1')
	role = Role.create(name: 'role1', action: Action.first, resource: Resource.first)
	RolesUser.create(role_id: role.id, user_id: user.id)
  end
end