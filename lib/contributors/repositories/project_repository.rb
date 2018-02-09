class ProjectRepository < Hanami::Repository
  def sorted
    projects.order { name.asc }
  end
end
