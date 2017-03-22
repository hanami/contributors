require_relative '../../../../apps/web/controllers/contributors/show'

RSpec.describe Web::Controllers::Contributors::Show do
  let(:action) { described_class.new }
  let(:params) { { id: contributor.github } }

  let(:repo) { ContributorRepository.new }
  let(:contributor) { repo.create(github: 'davydovanton') }
  let(:commit_repo) { CommitRepository.new }

  it { expect(action.call(params)[0]).to eq 200 }

  after { repo.clear }

  context '#contributor' do
    it 'returns contributor' do
      action.call(params)
      expect(action.contributor).to be_a Contributor
    end
  end

  context '#commits' do
    context 'when contributor has commits' do
      before do
        commit_repo.create(contributor_id: contributor.id, sha: '123', url: 'site.com')
      end

      after { commit_repo.clear }

      it 'returns contributor with all commits' do
        action.call(params)
        expect(action.commits).to all(be_a(Commit))
      end
    end

    context 'when contributor does not have commits' do
      it 'returns contributor without commits' do
        action.call(params)
        expect(action.commits).to eq []
      end
    end
  end
end
