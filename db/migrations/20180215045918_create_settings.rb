Hanami::Model.migration do
  change do
    create_table :settings do
      primary_key :id

      column :title, String
    end
  end
end
