RSpec.describe Admin::Controllers::Settings::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:settings_repo) { SettingRepository.new }

  after { settings_repo.clear }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    describe '#setting_history' do
      context 'when db empty' do
        before { action.call(params) }

        it { expect(action.setting_history).to eq [] }
      end

      context 'when db has settings' do
        before do
          settings_repo.create(title: 'Hanami')
          action.call(params)
        end

        it { expect(action.setting_history).to be_a Array }
        it { expect(action.setting_history).to all(be_a Setting) }
        it { expect(action.setting_history.first.title).to eq 'Hanami' }
      end
    end
  end
end
