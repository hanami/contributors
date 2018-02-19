RSpec.describe SettingRepository do
  let(:repo) { SettingRepository.new }

  after { repo.clear }

  describe '#for_display' do
    context 'when settings exist in db' do
      before { repo.create(title: 'Hanami') }

      it { expect(repo.for_display).to be_a Setting }
      it { expect(repo.for_display.title).to eq 'Hanami' }

      context 'and settings more than one' do
        before { repo.create(title: 'Hanami latest') }

        it { expect(repo.for_display.title).to eq 'Hanami latest' }
      end
    end

    context 'when settings exist in db' do
      it { expect(repo.for_display).to be_a Setting }
      it { expect(repo.for_display.title).to eq nil }
    end
  end
end
