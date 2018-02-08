RSpec.describe Admin::Views::Projects::Index, type: :view do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/projects/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe '#link_to_github' do
    let(:project) { Project.new(name: 'contributors') }

    it 'returns link to project github' do
      expect(view.link_to_github(project).to_s).to eq '<a href="https://github.com/hanami/contributors">contributors</a>'
    end
  end
end
