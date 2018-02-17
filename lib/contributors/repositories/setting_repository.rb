class SettingRepository < Hanami::Repository

  def for_display
    settings.select(:title).first
  end
end
