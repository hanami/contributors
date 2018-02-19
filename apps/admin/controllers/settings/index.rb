module Admin::Controllers::Settings
  class Index
    include Admin::Action

    expose :setting_history

    def call(params)
      @setting_history = SettingRepository.new.history
    end
  end
end
