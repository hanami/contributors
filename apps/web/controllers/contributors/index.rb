module Web::Controllers::Contributors
  class Index
    include Web::Action
    expose :contributors

    def call(params)
      @contributors = ContributorRepository.new.all
    end
  end
end
