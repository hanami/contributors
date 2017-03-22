require_relative '../../../../apps/web/views/contributors/show'

RSpec.describe Web::Views::Contributors::Show do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/contributors/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

end
