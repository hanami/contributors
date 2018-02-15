RSpec.describe Admin::Controllers::Settings::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  describe 'expose' do
    describe '#settings' do
      context 'when db empty' do
        before { action.call(params) }

        it { expect(action.settings.to_a).to eq [] }
      end

      context 'when db has settings' do
        let(:settings_repo) { SettingRepository.new }

        before do
          settings_repo.create(title: 'Hanami')
          action.call(params)
        end

        after do
          settings_repo.clear
        end

        it 'returns all settings' do
          settings = action.settings.to_a

          expect(settings).to all(be_a(Setting))
          expect(settings.count).to eq 1
        end
      end
    end
  end
end
