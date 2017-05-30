require_relative '../../../../apps/web/views/contributors/show'

RSpec.describe Web::Views::Contributors::Show do
  let(:contributor) { Contributor.new(github: 'antondavydov') }
  let(:exposures) { Hash[contributor: contributor, commits: []] }
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

  describe '#title' do
    it 'returns title' do
      expect(view.title).to eq('Commits for antondavydov')
    end
  end

  describe 'navbar link css' do
    it { expect(view.all_time_page_class).to eq nil }
    it { expect(view.today_page_class).to eq nil }
    it { expect(view.this_week_page_class).to eq nil }
    it { expect(view.this_month_page_class).to eq nil }
    it { expect(view.this_year_page_class).to eq nil }
    it { expect(view.faq_page_class).to eq nil }
  end
end
