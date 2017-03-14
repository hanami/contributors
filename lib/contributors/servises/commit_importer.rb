require_relative '../../http_request'

class CommitImporte
  API_URL = 'https://api.github.com/repos/hanami/%{project}/commits?page=%{page}&count=100'.freeze

  def call
    commit_repo = CommitRepository.new
    last_commit = CommitRepository.new.last
    projects = ProjectRepository.new.all

    contributors = ContributorRepository.new.all
    contributor_repo = ContributorRepository.new

    projects[0..3].each do |project|
      (1..10).each do |page|
        json = get_response(project, page)

        json.each do |data|
          next unless data['author']

          author = author_attributes(data)

          unless contributor = contributors.select { |c| c.github == author[:github] }.first
            contributor = contributor_repo.create(author)
          end

          commit = {
            contributor_id: contributor.id,
            project_id: project.id,
            sha: data['sha'],
            url: data['url']
          }

          if last_commit.sha == commit[:sha]
            return
          else
            commit_repo.create(commit)
          end
        end
      end
    end
  end

  private

  def author_attributes(data)
    { 
      github: data['author']['login'],
      avatar_url: data['author']['avatar_url'],
      full_name: data['commit']['author']['name']
    }
  end

  def get_response(project, page)
    params = { project: project.name, page: page }

    response = HttpRequest.new(API_URL % params).get
    return [] unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end
end
