class AddNewCommits
  def call
    repo.all.each do |contributor|
      AllCommits.new.call(contributor).each do |commit|
        begin
          commit_repo.create(commit)
        rescue
          next
        end
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
