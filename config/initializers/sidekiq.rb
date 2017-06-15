require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = Application[:redis]
end

Sidekiq.configure_client do |config|
  config.redis = Application[:redis]
end
