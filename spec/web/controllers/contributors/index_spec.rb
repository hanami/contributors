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

      xcontext 'when db has some commits' do
        before do
          3.times { |i| repo.create(github: "davydovanton##{i}") }
          action.call(params)
        end

        after { repo.clear }

        it 'returns all tasks' do
          expect(action.contributors).to all(be_a(Contributor))
          expect(action.contributors.count).to eq 3
        end
      end
    end
  end
end
