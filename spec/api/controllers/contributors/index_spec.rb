require_relative '../../../../apps/api/controllers/contributors/index'

RSpec.describe Api::Controllers::Contributors::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:repo)   { ContributorRepository.new }

  it { expect(action.call(params)).to be_success }

  context 'when db empty' do
    let(:json) { JSON.parse(action.call(params)[2][0]) }

    it { expect(json).to eq('count' => 0, 'data' => []) }
  end

  context 'when db has some commits' do
    before do
      contributor = repo.create(github: "davydovanton")

      CommitRepository.new.create(
        contributor_id: contributor.id,
        sha: "d244",
        url: "github.com",
        title: "test"
      )
    end

    after { repo.clear }

    let(:json) { JSON.parse(action.call(params)[2][0]) }

    it 'contains contributors information' do
      expect(json['count']).to eq 1
      expect(json['data'].count).to eq 1
    end
  end
end
