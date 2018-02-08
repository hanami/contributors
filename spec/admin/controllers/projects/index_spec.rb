RSpec.describe Admin::Controllers::Projects::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  describe 'expose' do
    describe '#projects' do
      context 'when db empty' do
        before { action.call(params) }

        it { expect(action.projects.to_a).to eq [] }
      end

      context 'when db has some projects' do
        let(:project_repo) { ProjectRepository.new }

        before do
          project_repo.create(name: 'contributors')
          action.call(params)
        end

        after do
          project_repo.clear
        end

        it 'returns all projects' do
          projects = action.projects.to_a

          expect(projects).to all(be_a(Project))
          expect(projects.count).to eq 1
        end
      end
    end
  end
end
