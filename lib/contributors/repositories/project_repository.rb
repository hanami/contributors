class ProjectRepository < Hanami::Repository
  def sorted
    projects.order { name.asc }.to_a
  end
end
