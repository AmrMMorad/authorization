Sequel.migration do
  up do
    create_table(:users_roles) do
      primary_key :id
      foreign_key :user_id, :users
      foreign_key :role_id, :roles
    end
  end

  down do
    drop_table(:users_roles)
  end
end