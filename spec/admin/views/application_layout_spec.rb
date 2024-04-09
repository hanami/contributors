require "spec_helper"

RSpec.describe Admin::Views::ApplicationLayout, type: :view do
  let(:layout)   { Admin::Views::ApplicationLayout.new(template, {}) }
  let(:rendered) { layout.render }
  let(:template) { Hanami::View::Template.new('apps/admin/templates/application.html.slim') }

  # it 'contains application name' do
  #   expect(rendered).to include('Admin')
  # end
end
