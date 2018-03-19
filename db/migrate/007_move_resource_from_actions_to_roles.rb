Sequel.migration do
	change do
		alter_table(:actions) do
			drop_foreign_key :resource_id
		end

		alter_table(:roles) do
			add_foreign_key :resource_id, :resources
		end
	end
end