module Web::Controllers::Contributors
  class Index
    include Web::Action
    expose :contributors

    def call(params)
      @contributors = ContributorRepository.new.all_with_commits
    end
  end
end
