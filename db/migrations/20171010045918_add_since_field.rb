Hanami::Model.migration do
  up do
    alter_table(:contributors) do
      add_column :since, DateTime
    end

    run <<-SQL
      UPDATE contributors
        SET since = contributor_first_commit.since
        FROM
          (
            SELECT min(created_at) as since, contributor_id
              FROM commits
              GROUP BY contributor_id
          ) AS contributor_first_commit
        WHERE
          id = contributor_first_commit.contributor_id
          AND contributors.since is NULL
    SQL
  end

  down do
    alter_table(:contributors) do
      drop_column :since
    end
  end
end
