class ContributorRepository < Hanami::Repository
  associations do
    has_many :commits
    has_many :projects
  end

  def all_with_commits_count
    with_commit_count.to_a.reverse!
  end

  # TODO: tests
  def with_commit_count
    contributors_schema = contributors.schema
    contributor_id = commits[:contributor_id].qualified

    contributors
      .project { [*contributors_schema, int::count(contributor_id).as(:commits_count)] }
      .join(commits)
      .group { [id] }
      .order(:commits_count)
  end

  def with_commit_range(range)
    with_commit_count
      .where(commits[:created_at].qualified => range)
      .to_a.reverse!
  end

  def find_by_github(github)
    contributors.where(github: github).as(Contributor).one
  end
end
