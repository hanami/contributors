class ContributorRepository < Hanami::Repository
  associations do
    has_many :commits
    has_many :projects
  end

  def all_with_commits(range = nil)
    query = if range
      aggregate(:commits)
        .contributors
        .join(commits)
        .where(commits[:created_at].qualified => range)
    else
      aggregate(:commits)
    end

    query.as(Contributor).to_a.sort_by { |c| c.commits.count }.reverse!
  end

  def find_by_github(github)
    contributors.where(github: github).as(Contributor).one
  end
end
