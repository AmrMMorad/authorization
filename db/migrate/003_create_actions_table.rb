Sequel.migration do
  up do
    create_table(:actions) do
      primary_key :id
      String :name, null: false
      foreign_key :resource_id, :resources
    end
  end

  down do
    drop_table(:actions)
  end
end