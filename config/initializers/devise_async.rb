# Supported options: :resque, :sidekiq, :delayed_job
# Devise::Async.backend = :resque
Devise::Async.setup do |config|
  config.enabled = true
end
