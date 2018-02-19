class SettingRepository < Hanami::Repository
  def for_display
    settings
      .order{ created_at.desc }
      .limit(1).map_to(Setting)
      .one || Setting.new
  end
end
