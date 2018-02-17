RSpec.describe SettingRepository do
  let(:repo) { SettingRepository.new }

  after { repo.clear }

  describe '#for_display' do

    before do
      repo.create(title: 'Hanami')
    end

    context 'returns settings with columns to display' do
      it { expect(repo.for_display).to be_a Setting }
      it { expect(repo.for_display.to_hash).to eq ({title: 'Hanami'}) }
    end
  end
end
