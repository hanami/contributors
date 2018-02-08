module Admin::Views::Projects
  class Index
    include Admin::View

    def link_to_github(project)
      link_to project.name, "https://github.com/hanami/#{project.name}"
    end
  end
end
