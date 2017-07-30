require_relative '../config/boot'

PROJECTS = %w[
  hanami.github.io
  hanami
  view
  utils
  validations
  model
  controller
  router
  assets
  community
  helpers
  mailer
  docs
  ecosystem
  contributors
  cli
]

repo = ProjectRepository.new
PROJECTS.each { |name| repo.create(name: name) }
AddNewContributors.new.call
AddNewCommits.new.call
