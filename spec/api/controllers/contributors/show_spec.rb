require_relative '../../../../apps/api/controllers/contributors/show'

RSpec.describe Api::Controllers::Contributors::Show do
  let(:action) { described_class.new }
  let(:params) { { id: contributor.github } }

  let(:repo) { ContributorRepository.new }
  let(:contributor) { repo.create(github: 'davydovanton') }

  let(:json) { JSON.parse(action.call(params)[2][0]) }

  it { expect(action.call(params)).to be_success }

  after { repo.clear }

  context 'when db empty' do
    let(:params) { { id: 'empty' } }

    it { expect(action.call(params)).to be_success }
    it { expect(json).to eq("status" => "error", "message" => "contributor not found") }
  end

  context 'when user exist' do
    let(:params) { { id: contributor.github } }

    it { expect(action.call(params)).to be_success }
    it { expect(json).to eq("status" => "ok", "contributor" => {"github"=>"davydovanton", "avatar_url"=>nil, "commits"=>[]}) }
  end
end
