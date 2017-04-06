require_relative '../../../../apps/web/controllers/contributors/index'

RSpec.describe Web::Controllers::Contributors::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:repo)   { ContributorRepository.new }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    describe '#contributors' do
      context 'when db empty' do
        before { action.call(params) }

        it { expect(action.contributors).to eq [] }
      end

      context 'when db has some commits' do
        let(:commit_repo) { CommitRepository.new }
        let(:project_repo) { ProjectRepository.new }
        let(:project) { project_repo.create(name: 'hanami') }

        before do
          3.times do |i|
            contributor = repo.create(github: "davydovanton##{i}")
            commit_repo.create(project_id: project.id, contributor_id: contributor.id)
          end

          action.call(params)
        end

        after do
          repo.clear
          commit_repo.clear
          project_repo.clear
        end

        it 'returns all contributors' do
          expect(action.contributors).to all(be_a(Contributor))
          expect(action.contributors.count).to eq 3
        end
      end
    end
  end
end
