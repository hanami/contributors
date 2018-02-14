RSpec.describe Operations::List do
  let(:operation) { described_class.new }
  subject { operation.call }

  it { expect(subject).to be_successful }
  it { expect(subject.contributors).to eq [] }
end
