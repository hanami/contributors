require_relative '../../../../apps/web/views/static/faq'

RSpec.describe Web::Views::Static::Faq do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/static/faq.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
end
