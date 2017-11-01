RSpec.describe Web::Controllers::Statistics::Show do
  let(:action) { described_class.new }
  let(:params) { { github: contributor.github } }

  let(:repo) { ContributorRepository.new }
  let(:contributor) { repo.create(github: 'davydovanton') }

  after { repo.clear }

  it { expect(action.call(params)).to be_success }

  context '#contributor' do
    before { action.call(params) }

    it { expect(action.contributor).to be_a Contributor }
  end
end
