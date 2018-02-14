require_relative '../config/boot'

GITHUB_ORGANIZATION = "hamani".freeze

repo = ProjectRepository.new
AllProjects.new(GITHUB_ORGANIZATION).call.each do |project|
  repo.create(project)
end
AddNewContributors.new.call
AddNewCommits.new.call
