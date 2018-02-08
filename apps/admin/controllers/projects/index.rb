module Admin::Controllers::Projects
  class Index
    include Admin::Action

    expose :projects

    def call(params)
      @projects = ProjectRepository.new.sorted
    end
  end
end
