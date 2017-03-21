require_relative '../../http_request'

class AllContributors
  API_URL = 'https://api.github.com/repos/hanami/%{project}/stats/contributors?client_id=%{github_id}&client_secret=%{github_key}'.freeze

  def call
    contributors = []

    # TODO: doesn't work. we need to find other way to get all contributors for all repos
    ProjectRepository.new.all.each do |project|
      get_response(project).each { |data| contributors << contributor_data(data) }
    end

    contributors.uniq { |contributor| contributor[:github] }
  end

  private

  def contributor_data(data)
    { 
      github: data['author']['login'],
      avatar_url: data['author']['avatar_url']
    }
  end

  def get_response(project)
    params = {
      project: project.name,
      github_id: ENV['GITHUB_API_ID'],
      github_key: ENV['GITHUB_API_KEY']
    }

    response = HttpRequest.new(API_URL % params).get
    return [] unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end
end
