require_relative '../../http_request'

class AllProjects
  API_URL = 'https://api.github.com/orgs/%{owner}/repos?client_id=%{github_id}&client_secret=%{github_key}&page=%{page}&count=100'.freeze

  def initialize(owner)
    @owner = owner
  end

  def call
    projects = []
    page = 1

    while (repositories = get_response(page)) && !repositories.empty?
      page += 1
      repositories.each do |data|
        projects.push project_data(data)
      end
      break
    end

    projects
  end

  private

  def project_data(data)
    {
      name: data.fetch('name'),
      owner: data.fetch('owner').fetch('login')
    }
  end

  def get_response(page)
    params = {
      page: page,
      owner: @owner,
      github_id: ENV['GITHUB_API_ID'],
      github_key: ENV['GITHUB_API_KEY']
    }

    response = HttpRequest.new(API_URL % params).get
    return [] unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end
end
