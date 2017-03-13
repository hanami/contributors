Hanami::Model.migration do
  change do
    create_table :projects do
      primary_key :id

      column :name, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
