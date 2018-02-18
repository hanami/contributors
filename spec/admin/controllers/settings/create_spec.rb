RSpec.describe Admin::Controllers::Settings::Create, type: :action do
  let(:action) { described_class.new }
  let(:settings_repo) { SettingRepository.new }

  after { settings_repo.clear }


  describe '#call' do
    context 'correct params' do
      let(:params) { Hash[setting: {title: 'hello'}] }

      it 'creates a new setting record' do
        expect{action.call(params)}.to change{settings_repo.all.count}.by(1)
      end
    end

    context 'incorrect params' do
      let(:params) { Hash[] }

      it 'does not creates a new setting record' do
        expect{action.call(params)}.to_not change{settings_repo.all.count}
      end

      it 'returns 422' do
        response = action.call(params)
        expect(response[0]).to eq 422
      end
    end
  end
end
