module Web::Controllers::Statistics
  class Show
    include Web::Action

    expose :contributor, :commits

    def call(params)
      @contributor = ContributorRepository.new.find_by_github(params[:github])
    end
  end
end
