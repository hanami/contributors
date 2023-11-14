RSpec.describe Operations::Detail do
  let(:operation) { described_class.new }
  subject { operation.call }

  it { expect(subject).to be_successful }
  it { expect(subject.contributor).to eq nil }
end
