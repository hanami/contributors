require_relative '../json'

module Api::Controllers::Contributors
  class Index
    include Api::Action
    include Hanami::Action::Json

    def call(params)
      contributors = repo.all_with_commits_count.map! { |c| serializator.new(c) }
      send_json(count: contributors.size, data: contributors)
    end

    private

    def repo
      @repo ||= ContributorRepository.new
    end
  end
end
