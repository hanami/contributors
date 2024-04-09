require_relative '../../http_request'

class AllContributors
  API_URL = 'https://api.github.com/repos/hanami/%{project}/commits?client_id=%{github_id}&client_secret=%{github_key}&page=%{page}&count=100'.freeze

  def call
    projects = ProjectRepository.new.all
    contributors = []

    projects.each do |project|
      page = 1
      while (project_commits = get_response(project, page)) && !project_commits.empty?
        page += 1
        project_commits.each do |data|
          next unless data['author']
          contributors << contributor_data(data)
        end
      end
    end

    contributors.uniq! { |c| c[:github] }
  end

  def for_project(project)
    contributors = []

    page = 1
    while (project_commits = get_response(project, page)) && !project_commits.empty?
      page += 1
      project_commits.each do |data|
        next unless data['author']
        contributors << contributor_data(data)
      end
    end

    contributors.uniq! { |c| c[:github] }
  end

  private

  def contributor_data(data)
    {
      github: data['author']['login'],
      avatar_url: data['author']['avatar_url']
    }
  end

  def get_response(project, page)
    params = {
      page: page,
      project: project.name,
      github_id: ENV['GITHUB_API_ID'],
      github_key: ENV['GITHUB_API_KEY']
    }

    response = HttpRequest.new(API_URL % params).get
    return [] unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end
end
