Hanami::Model.migration do
  change do
    add_column :settings, :created_at, DateTime, null: false
  end
end
