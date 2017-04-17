module Api::Controllers::Contributors
  class Index
    include Api::Action

    def call(params)
      contributors =
        repo.all_with_commits_count.map! { |c| serialize(c) }

      self.body = JSON.generate(
        count: contributors.size,
        data: contributors
      )
    end

    private

    def serialize(contributor)
      Api::Serializators::Contributors::Index.new(contributor)
    end

    def repo
      @repo ||= ContributorRepository.new
    end
  end
end
