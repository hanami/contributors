class SettingRepository < Hanami::Repository

  def for_display
    settings.select(:title).last
  end
end
