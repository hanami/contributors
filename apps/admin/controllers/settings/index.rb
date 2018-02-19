module Admin::Controllers::Settings
  class Index
    include Admin::Action

    expose :settings

    def call(params)
      @settings = SettingRepository.new.latest
    end
  end
end
