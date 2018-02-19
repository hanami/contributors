RSpec.describe SettingRepository do
  let(:repo) { SettingRepository.new }

  after { repo.clear }

  describe '#latest' do
    context 'when settings exist in db' do
      before { repo.create(title: 'Hanami') }

      it { expect(repo.latest).to be_a Setting }
      it { expect(repo.latest.title).to eq 'Hanami' }

      context 'and settings more than one' do
        before { repo.create(title: 'Hanami latest') }

        it { expect(repo.latest.title).to eq 'Hanami latest' }
      end
    end

    context 'when settings exist in db' do
      it { expect(repo.latest).to be_a Setting }
      it { expect(repo.latest.title).to eq nil }
    end
  end

  describe '#history' do
    context 'when settings exist in db' do
      before do
        repo.create(title: 'Hanami #1')
        repo.create(title: 'Hanami #2')
      end

      it { expect(repo.history).to be_a Array }
      it { expect(repo.history).to all(be_a Setting) }
      it { expect(repo.history.map(&:title)).to eq ['Hanami #2', 'Hanami #1'] }
    end

    context 'when settings not exist in db' do
      it { expect(repo.history).to eq [] }
    end
  end
end
