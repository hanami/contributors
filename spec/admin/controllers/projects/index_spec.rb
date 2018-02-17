RSpec.describe Admin::Controllers::Projects::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:project_repo) { ProjectRepository.new }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    describe '#projects' do
      context 'when db empty' do
        before { action.call(params) }

        it { expect(action.projects.to_a).to eq [] }
      end

      context 'when db has some projects' do
        before do
          project_repo.create(name: 'contributors')
          action.call(params)
        end

        after { project_repo.clear }

        subject { action.projects }

        it { expect(subject).to all(be_a(Project)) }
        it { expect(subject.count).to eq 1 }
      end
    end
  end
end
