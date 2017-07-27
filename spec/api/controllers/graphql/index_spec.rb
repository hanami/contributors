require_relative '../../../../apps/api/controllers/graphql/index'

RSpec.describe Api::Controllers::Graphql::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
