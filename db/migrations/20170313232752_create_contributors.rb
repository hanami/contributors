Hanami::Model.migration do
  change do
    create_table :contributors do
      primary_key :id

      column :full_name,  String
      column :github,     String
      column :avatar_url, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
