RSpec.describe AddNewCommits do
  let(:contributor_repo) { ContributorRepository.new }
  let(:commit_repo) { CommitRepository.new }
  let(:project_repo) { ProjectRepository.new }

  let!(:contributor) { contributor_repo.create(github: 'artofhuman') }
  let!(:project) { project_repo.create(name: 'hanami') }

  after do
    commit_repo.clear
    contributor_repo.clear
  end

  it 'adds contributor commits to the repo' do
    VCR.use_cassette("commits") do
      described_class.new.call

      commits = commit_repo.all_for_contributor(contributor.id).to_a

      expect(commits).not_to be_empty
      expect(commits.first.url).to be
      expect(commits.first.title).to be
      expect(commits.first.project_id).to eq(project.id)
      expect(contributor_repo.last.since).to be
    end
  end

  it 'adds contributor commits to the repo for given project' do
    VCR.use_cassette("commits") do
      described_class.new.for_project(project)

      commits = commit_repo.all_for_contributor(contributor.id).to_a

      expect(commits).not_to be_empty
      expect(commits.first.url).to be
      expect(commits.first.title).to be
      expect(commits.first.project_id).to eq(project.id)
      expect(contributor_repo.last.since).to be
    end
  end
end
