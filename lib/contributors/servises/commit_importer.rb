require_relative '../../http_request'

class CommitImporte
  API_URL = 'https://api.github.com/repos/hanami/%{project}/commits?page=%{page}&count=100&author=%{author}'.freeze

  def call
    projects = ProjectRepository.new.all

    contributor_repo = ContributorRepository.new
    contributors = contributor_repo.all

    contributor = contributors.select { |c| c.github == 'davydovanton' }.first

    commits = []

    projects.each do |project|
      page = 1
      while (project_commits = get_response(project, contributor, page)) && !project_commits.empty?
        page += 1
        project_commits.map do |data|
          commits << {
            contributor_id: contributor.id,
            project_id: project.id,
            sha: data['sha'],
            url: data['url']
          }
        end

        sleep 1
      end
    end

    commits
  end

  private

  def get_response(project, contributors, page)
    params = { project: project.name, author: contributors.github, page: page }

    response = HttpRequest.new(API_URL % params).get
    return [] unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end
end
