module Api::Controllers::Contributors
  class Show
    include Api::Action

    def call(params)
      contributor = ContributorRepository.new.find_by_github(params[:id])

      if contributor
        commits = CommitRepository.new.all_for_contributor(contributor.id)
        data = serializator.new(**contributor, commits: commits)

        send_json(status: :ok, contributor: data)
      else
        send_json(status: :error, message: 'contributor not found')
      end
    end

    private

    def repo
      @repo ||= ContributorRepository.new
    end
  end
end
