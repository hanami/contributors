class ContributorRepository < Hanami::Repository
  associations do
    has_many :commits
    has_many :projects
  end

  def all_with_commits
    aggregate(:commits).to_a.sort_by { |c| c.commits.count }.reverse!
  end
end
