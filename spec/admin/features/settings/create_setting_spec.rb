require 'features_helper'

describe 'Create a setting' do
  let(:repo) { SettingRepository.new }
  include_context 'authenticated'

  after { repo.clear }

  context 'No setting before' do
    it 'can create a new setting' do
      visit '/admin/settings/new'

      within 'form#setting-form' do
        fill_in 'Title',  with: 'Hanami'

        click_button 'Create'
      end

      expect(current_path).to eq('/admin/settings')
      expect(page).to have_content('Hanami')
    end
  end

  context 'Previous setting before' do

    before { repo.create(title: 'dry-rb') }

    it 'preview setting value are displayed' do
      visit '/admin/settings/new'

      expect(page).to have_field('Title', with: 'dry-rb')
    end
  end
end
