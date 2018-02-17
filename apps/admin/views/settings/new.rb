module Admin::Views::Settings
  class New
    include Admin::View

    def form(settings)
      form_for :setting, routes.settings_path, class: 'setting-form' do
        label :title
        text_field :title, value: settings.title

        submit 'Create'
      end
    end
  end
end
