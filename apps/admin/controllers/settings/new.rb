module Admin::Controllers::Settings
  class New
    include Admin::Action

    expose :settings

    def call(params)
      @settings = SettingRepository.new.for_display
    end
  end
end
