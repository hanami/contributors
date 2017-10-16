class AddNewCommits
  def call
    repo.all.each do |contributor|
      AllCommits.new.call(contributor)
        .each { |commit| create_commit(commit) }
    end
  end

  private

  def create_commit(payload)
    begin
      commit_repo.create(payload)
    rescue
      nil
    end
  end

  def repo
    @repo ||= ContributorRepository.new
  end

  def commit_repo
    @commit_repo ||= CommitRepository.new
  end
end
