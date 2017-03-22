RSpec.describe ContributorRepository do
  let(:repo) { ContributorRepository.new }
  let(:contributor) { repo.create(github: 'davydovanton') }

  describe '#find_with_commits' do
    let(:commit_repo) { CommitRepository.new }

    after { repo.clear }

    context 'when contributor has commits' do
      before do
        commit_repo.create(contributor_id: contributor.id, sha: '123', url: 'site.com')
      end

      after { commit_repo.clear }

      it { expect(repo.find_with_commits(contributor.github).commits).to all(be_a(Commit)) }
    end

    context 'when contributor does not have commits' do
      it { expect(repo.find_with_commits(contributor.github).commits).to eq [] }
    end
  end
end
