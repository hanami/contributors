module Web::Controllers::Contributors
  class Show
    include Web::Action
    expose :contributor, :commits

    def call(params)
      @contributor = ContributorRepository.new.find_by_github(params[:id])
      @commits = CommitRepository.new.where(contributor_id: @contributor.id).to_a
    end
  end
end
