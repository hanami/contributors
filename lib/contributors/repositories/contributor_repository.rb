class ContributorRepository < Hanami::Repository
  associations do
    has_many :commits
    has_many :projects
  end

  def all_with_commits
    aggregate(:commits).as(Contributor).to_a.sort_by { |c| c.commits.count }.reverse!
  end

  def find_with_commits(github)
    aggregate(:commits).where(github: github).as(Contributor).one
  end
end
