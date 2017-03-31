require_relative '../../../../apps/web/views/static/faq'

RSpec.describe Web::Views::Static::Faq do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/static/faq.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe 'navbar link css' do
    it { expect(view.all_time_page_class).to eq nil }
    it { expect(view.today_page_class).to eq nil }
    it { expect(view.this_week_page_class).to eq nil }
    it { expect(view.this_month_page_class).to eq nil }
    it { expect(view.this_year_page_class).to eq nil }
    it { expect(view.faq_page_class).to eq 'active' }
  end
end
