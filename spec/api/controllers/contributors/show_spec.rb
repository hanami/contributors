require_relative '../../../../apps/api/controllers/contributors/show'

RSpec.describe Api::Controllers::Contributors::Show do
  let(:action) { described_class.new }
  let(:params) { { id: contributor.github } }

  let(:repo) { ContributorRepository.new }
  let(:contributor) { repo.create(github: 'davydovanton') }

  it { expect(action.call(params)).to be_success }

  after { repo.clear }

  context 'when db empty' do
    let(:params) { { id: 'empty' } }

    it { expect(action.call(params)).to be_success }
    it { expect(action.call(params)[2].first).to match('"status":"error","message":"contributor not found"') }
  end
end
