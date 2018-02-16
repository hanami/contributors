RSpec.describe Admin::Controllers::Settings::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  let(:settings_repo) { SettingRepository.new }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    describe '#settings' do
      context 'when db empty' do
        before { action.call(params) }

        it { expect(action.settings.to_a).to eq [] }
      end

      context 'when db has settings' do
        before do
          settings_repo.create(title: 'Hanami')
          action.call(params)
        end

        after { settings_repo.clear }

        it { expect(action.settings).to eq({title: 'Hanami'}) }
      end
    end
  end
end
