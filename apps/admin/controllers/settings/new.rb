module Admin::Controllers::Settings
  class New
    include Admin::Action

    expose :settings

    def call(params)
      @settings = SettingRepository.new.latest
    end
  end
end
