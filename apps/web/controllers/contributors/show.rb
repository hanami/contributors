module Web::Controllers::Contributors
  class Show
    include Web::Action
    include Hanami::Pagination::Action

    expose :contributor, :commits, :commits_count

    def call(params)
      @contributor = ContributorRepository.new.find_by_github(params[:id])
      commits = CommitRepository.new.all_for_contributor(@contributor.id)

      @commits_count = commits.to_a.size
      @commits = all_for_page(commits)
    end
  end
end
