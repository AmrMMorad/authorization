Sequel.migration do
  up do
    create_table(:resources) do
      primary_key :id
      String :name, null: false
    end
  end

  down do
    drop_table(:resources)
  end
end