class SettingRepository < Hanami::Repository
  def history
    settings
      .order{ created_at.desc }
      .map_to(Setting)
      .to_a
  end

  def latest
    settings
      .order{ created_at.desc }
      .limit(1).map_to(Setting)
      .one || Setting.new
  end
end
