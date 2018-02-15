module Admin::Controllers::Settings
  class Index
    include Admin::Action

    expose :settings

    def call(params)
      @settings = SettingRepository.new.for_display.first
    end
  end
end
