Sequel.migration do
  change do
    rename_table(:users_roles, :roles_users)
  end
end