class ContributorRepository < Hanami::Repository
  associations do
    has_many :commits
    has_many :projects
  end

  def all_with_commits
    aggregate(:commits).as(Contributor).to_a.sort_by { |c| c.commits.count }.reverse!
  end

  def with_commit_range(range)
    aggregate(:commits)
      .contributors
      .join(commits)
      .where(commits[:created_at].qualified => range)
      .as(Contributor).to_a
      .sort_by { |c| c.commits.count }.reverse!
      .uniq! { |c| c.github }
  end

  def find_by_github(github)
    contributors.where(github: github).as(Contributor).one
  end
end
