RSpec.describe AllCommits do
  let(:repo) { ProjectRepository.new }
  let(:contributor) { Contributor.new(id: 1, github: 'artofhuman') }

  let!(:project) { repo.create(name: 'hanami') }

  after do
    repo.clear
  end

  it 'returns contributor commits' do
    VCR.use_cassette("commits") do
      result = AllCommits.new.call(contributor)

      expect(result).not_to be_empty

      commit = result.first

      expect(commit[:contributor_id]).to eq(contributor.id)
      expect(commit[:project_id]).to eq(project.id)
      expect(commit[:created_at]).to be_a(Time)
      expect(commit[:sha]).to be
      expect(commit[:url]).to be
    end
  end
end
