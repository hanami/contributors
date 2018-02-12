require_relative '../../../spec_helper'

describe Admin::Controllers::Projects::Create do
  let(:action) { Admin::Controllers::Projects::Create.new }
  let(:params) { Hash[project: { name: 'Awesome Project' }] }
  let(:repository) { ProjectRepository.new }

  before do
    repository.clear
  end

  it 'creates a new project' do
    action.call(params)
    project = repository.last

    expect(project.id).not_to be_nil
    expect(project.name).to eq(params.dig(:project, :name))
  end

  it 'redirects the user to the projects listing' do
    response = action.call(params)
    flash = action.exposures[:flash]

    expect(flash[:message]).to eq('Project added!')
    expect(response[0]).to eq(302)
    expect(response[1]['Location']).to include('/projects')
  end

  it 'render creation form back' do
    response = action.call({})

    expect(response[0]).to eq(422)
  end
end
