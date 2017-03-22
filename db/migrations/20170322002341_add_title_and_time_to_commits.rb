Hanami::Model.migration do
  change do
    add_column :commits, :title, String
    add_column :commits, :date, String
  end
end
