class AddNewCommits
  def call
    repo.all.each do |contributor|
      begin
        AllCommits.new.call(contributor).each { |c| commit_repo.create(c) }
      rescue
        next
      end
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
