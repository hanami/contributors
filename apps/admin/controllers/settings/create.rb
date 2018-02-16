module Admin::Controllers::Settings
  class Create
    include Admin::Action

    params do
      required(:setting).schema do
        required(:title).filled(:str?)
      end
    end

    def call(params)
      if params.valid?
        SettingRepository.new.create(params[:setting])

        redirect_to routes.settings_path
      else
        self.status = 422
      end
    end
  end
end
