RSpec.describe ContributorRepository do
  let(:repo) { ContributorRepository.new }
  let(:contributor) { repo.create(github: 'davydovanton') }

  let(:commit_repo) { CommitRepository.new }

  after { repo.clear }

  describe '#find_by_github' do
    context 'when contributor has commits' do
      after { commit_repo.clear }

      it { expect(repo.find_by_github(contributor.github)).to be_a Contributor }
      it { expect(repo.find_by_github(contributor.github).github).to eq contributor.github }
    end

    context 'when contributor does not have commits' do
      it { expect(repo.find_by_github('github')).to eq nil }
    end
  end

  describe '#all_with_commits' do
    before do
      other_commiter = repo.create(github: 'test')

      commit_repo.create(contributor_id: contributor.id, created_at: Time.now - 60 * 60 * 22)
      commit_repo.create(contributor_id: other_commiter.id, created_at: Time.now - 60 * 60 * 24 * 5)
    end

    after { commit_repo.clear }

    let(:range) { (Time.now - 60 * 60 * 24)..Time.now }

    it { expect(repo.all_with_commits(range).count).to eq 1 }
    it { expect(repo.all_with_commits(range).last.github).to eq 'davydovanton' }
    it { expect(repo.all_with_commits(range).last.commits.count).to eq 1 }
  end
end
