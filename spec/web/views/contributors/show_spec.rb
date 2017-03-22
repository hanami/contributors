require_relative '../../../../apps/web/views/contributors/show'

RSpec.describe Web::Views::Contributors::Show do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/contributors/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe '#project_name' do
    context 'when url contain project' do
      let(:commit) { Commit.new(url: 'github.com/hanami/hanami/') }

      it { expect(view.project_name(commit)).to eq 'hanami' }
    end

    context 'when url not contain project' do
      let(:commit) { Commit.new(url: '') }

      it { expect(view.project_name(commit)).to eq nil }
    end
  end
end
