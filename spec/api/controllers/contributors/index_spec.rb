require_relative '../../../../apps/api/controllers/contributors/index'

RSpec.describe Api::Controllers::Contributors::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to be_success }

  it { expect(action.call(params)).to be_success }

  context 'when db empty' do
    before { action.call(params) }

    let(:json) { JSON.parse(action.call(params)[2][0]) }

    it { expect(json).to eq('count' => 0, 'data' => []) }
  end
end
