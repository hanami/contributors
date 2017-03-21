class AddNewCommits
  def call
    repo.all.each do |contributor|
      AllCommits.new.call(contributor).each { |c| commit_repo.create(c) }
    end
  end

  private

  def repo
    @repo ||= ContributorRepository.new
  end

  def commit_repo
    @commit_repo ||= CommitRepository.new
  end
end
