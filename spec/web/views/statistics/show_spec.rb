RSpec.describe Web::Views::Statistics::Show do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/statistics/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
end
