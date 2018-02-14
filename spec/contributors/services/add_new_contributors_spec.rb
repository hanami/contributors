RSpec.describe AddNewContributors do
  let(:contributors_repo) { ContributorRepository.new }
  let(:project_repo) { ProjectRepository.new}

  before do
    project_repo.create(name: 'contributors', owner: 'hanami')
  end

  after do
    project_repo.clear
    contributors_repo.clear
  end

  it 'adds new contributors to repo' do
    VCR.use_cassette("contributors") do
      described_class.new.call
    end

    expect(contributors_repo.find_by_github('jodosha')).to be
    expect(contributors_repo.find_by_github('davydovanton')).to be
  end

  context 'when contributor already in repo' do
    before do
      contributors_repo.create(github: 'davydovanton')
    end

    it 'does not adds' do
      VCR.use_cassette("contributors") do
        expect { described_class.new.call }
          .not_to change { contributors_repo.contributors.where(github: 'davydovanton').count }
      end
    end
  end
end
