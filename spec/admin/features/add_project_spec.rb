require 'features_helper'

describe 'Add a project' do
  before do
    page.driver.browser.basic_authorize(ADMIN_USERNAME, ADMIN_PASSWORD)
  end

  after do
    ProjectRepository.new.clear
  end

  it 'can create a new project' do
    visit '/admin/projects/new'

    within 'form#project-form' do
      fill_in 'Name',  with: 'New project'

      click_button 'Create'
    end

    expect(current_path).to eq('/admin/projects')
    expect(page).to have_content('New project')
  end

  it 'has validation errors' do
    visit '/admin/projects/new'

    within 'form#project-form' do
      click_button 'Create'
    end

    expect(current_path).to eq('/admin/projects')
    expect(page).to have_content('Name must be filled')
  end
end
