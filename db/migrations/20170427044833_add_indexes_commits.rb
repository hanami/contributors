Hanami::Model.migration do
  change do
    add_index :commits, :contributor_id
    add_index :contributors, :github
  end
end
