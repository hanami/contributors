require_relative '../../../../apps/web/views/contributors/index'

RSpec.describe Web::Views::Contributors::Index do
  let(:exposures) { Hash[params: params] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/contributors/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:params)    { {} }

  describe '#link_to_github' do
    let(:contributor) { Contributor.new(github: 'davydovanton') }

    it 'returns link to contributor github' do
      expect(view.link_to_github(contributor).to_s).to eq '<a href="/contributors/davydovanton">davydovanton</a>'
    end
  end

  describe 'navbar link css' do
    it { expect(view.all_time_page_class).to eq 'active' }
    it { expect(view.today_page_class).to eq nil }
    it { expect(view.this_week_page_class).to eq nil }
    it { expect(view.this_month_page_class).to eq nil }
    it { expect(view.this_year_page_class).to eq nil }
    it { expect(view.faq_page_class).to eq nil }

    context 'when params range set to day' do
      let(:params) { { range: 'day' } }

      it { expect(view.all_time_page_class).to eq nil }
      it { expect(view.today_page_class).to eq 'active' }
      it { expect(view.this_week_page_class).to eq nil }
      it { expect(view.this_month_page_class).to eq nil }
      it { expect(view.this_year_page_class).to eq nil }
      it { expect(view.faq_page_class).to eq nil }
    end

    context 'when params range set to week' do
      let(:params) { { range: 'week' } }

      it { expect(view.all_time_page_class).to eq nil }
      it { expect(view.today_page_class).to eq nil }
      it { expect(view.this_week_page_class).to eq 'active' }
      it { expect(view.this_month_page_class).to eq nil }
      it { expect(view.this_year_page_class).to eq nil }
      it { expect(view.faq_page_class).to eq nil }
    end

    context 'when params range set to month' do
      let(:params) { { range: 'month' } }

      it { expect(view.all_time_page_class).to eq nil }
      it { expect(view.today_page_class).to eq nil }
      it { expect(view.this_week_page_class).to eq nil }
      it { expect(view.this_month_page_class).to eq 'active' }
      it { expect(view.this_year_page_class).to eq nil }
      it { expect(view.faq_page_class).to eq nil }
    end

    context 'when params range set to year' do
      let(:params) { { range: 'year' } }

      it { expect(view.all_time_page_class).to eq nil }
      it { expect(view.today_page_class).to eq nil }
      it { expect(view.this_week_page_class).to eq nil }
      it { expect(view.this_month_page_class).to eq nil }
      it { expect(view.this_year_page_class).to eq 'active' }
      it { expect(view.faq_page_class).to eq nil }
    end
  end
end
