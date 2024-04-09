class AddNewContributorsForProjectWorker
  include Sidekiq::Worker

  def perform(project)
    AddNewContributors.new.for_project(project)
    AddNewCommits.new.for_project(project)
  end
end
