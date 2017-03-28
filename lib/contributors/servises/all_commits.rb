require_relative '../../http_request'

class AllCommits
  API_URL = 'https://api.github.com/repos/hanami/%{project}/commits?client_id=%{github_id}&client_secret=%{github_key}&page=%{page}&count=100&author=%{author}'.freeze

  COMMITS_COUNT_ON_PAGE = 100

  def call(contributor)
    projects = ProjectRepository.new.all
    commits = []

    projects.each do |project|
      page = 1
      while (project_commits = get_response(project, contributor, page)) && !project_commits.empty?
        page += 1
        project_commits.each { |data| commits << commit_information(contributor, project, data) }
      end
    end

    commits
  end

  private

    def commit_information(contributor, project, data)
      {
        contributor_id: contributor.id,
        project_id: project.id,
        title: data['commit']['message'].lines.first.chomp,
        created_at:  Time.parse(data['commit']['author']['date']),
        sha:   data['sha'],
        url:   data['html_url']
      }
    end

  def get_response(project, contributors, page)
    params = {
      project: project.name,
      author: contributors.github,
      page: page,
      github_id: ENV['GITHUB_API_ID'],
      github_key: ENV['GITHUB_API_KEY']
    }

    response = HttpRequest.new(API_URL % params).get
    return [] unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end
end
