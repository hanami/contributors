module Api::Controllers::Contributors
  class Index
    include Api::Action

    def call(params)
      contributors = repo.all_with_commits_count
        .map! { |c| ContributorSerialization.new(c) }

      self.body = JSON.generate(
        count: contributors.size,
        data: contributors
      )
    end

    private

    def repo
      @repo ||= ContributorRepository.new
    end
  end
end
