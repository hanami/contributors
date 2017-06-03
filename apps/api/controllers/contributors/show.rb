module Api::Controllers::Contributors
  class Show
    include Api::Action

    def call(params)
      send_json(responce_hash(repo.find_by_github(params[:id])))
    end

    private

    ERROR_RESPONCE = { status: :error, message: 'contributor not found' }

    def responce_hash(contributor)
      return ERROR_RESPONCE unless contributor

      commits = CommitRepository.new.all_for_contributor(contributor.id).to_a.map(&:to_h)

      {
        status: :ok,
        contributor: serializator.new(**contributor, commits: commits)
      }
    end

    def repo
      @repo ||= ContributorRepository.new
    end
  end
end
