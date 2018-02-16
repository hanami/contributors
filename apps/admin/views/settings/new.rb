module Admin::Views::Settings
  class New
    include Admin::View

    def form(settings)
      form_for :setting, routes.create_settings_path do
        label :title
        text_field :title, value: settings.title

        submit 'Create'
      end
    end
  end
end
