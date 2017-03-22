module Web::Controllers::Contributors
  class Show
    include Web::Action
    expose :contributor

    def call(params)
      @contributor = ContributorRepository.new.find_with_commits(params[:id])
    end
  end
end
