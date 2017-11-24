Hanami::Model.migration do
  up do
    alter_table(:projects) do
      add_column :owner, String
    end
  end

  down do
    alter_table(:projects) do
      drop_column :owner
    end
  end
end
