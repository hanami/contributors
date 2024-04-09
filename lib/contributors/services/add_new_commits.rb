class AddNewCommits
  def call
    commits_finder = AllCommits.new

    contributor_repo.all.each do |contributor|
      commits_finder.call(contributor)
        .each { |commit| create_commit(commit) }
    end

    contributor_repo.fill_since
  end

  def for_project(project)
    commits_finder = AllCommits.new

    contributor_repo.all.each do |contributor|
      commits_finder.for_project(project, contributor)
        .each { |commit| create_commit(commit) }
    end

    contributor_repo.fill_since
  end

  private

  def create_commit(payload)
    begin
      commit_repo.create(payload)
    rescue
      nil
    end
  end

  def contributor_repo
    @repo ||= ContributorRepository.new
  end

  def commit_repo
    @commit_repo ||= CommitRepository.new
  end
end
