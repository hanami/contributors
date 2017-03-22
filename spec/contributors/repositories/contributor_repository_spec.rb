RSpec.describe ContributorRepository do
  let(:repo) { ContributorRepository.new }
  let(:contributor) { repo.create(github: 'davydovanton') }

  describe '#find_by_github' do
    let(:commit_repo) { CommitRepository.new }

    after { repo.clear }

    context 'when contributor has commits' do
      after { commit_repo.clear }
      it { expect(repo.find_by_github(contributor.github)).to be_a Contributor }
      it { expect(repo.find_by_github(contributor.github).github).to eq contributor.github }
    end

    context 'when contributor does not have commits' do
      it { expect(repo.find_by_github('github')).to eq nil }
    end
  end
end
