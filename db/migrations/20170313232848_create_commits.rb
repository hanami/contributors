Hanami::Model.migration do
  change do
    create_table :commits do
      primary_key :id
      foreign_key :contributor_id, :contributors, on_delete: :cascade
      foreign_key :project_id,     :projects,     on_delete: :cascade

      column :sha, String
      column :url, String, unique: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
