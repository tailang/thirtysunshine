require 'redis'
require 'redis-namespace'
require 'redis/objects'

redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]

Redis::Objects.redis = Redis.new(:host => redis_config['host'], :port => redis_config['port'])
#port你的redis服务端口
#端口配置可以在redis/64bit(根据系统判定)目录下的redis.conf文件中，这行： port:6379
sidekiq_url = "redis://#{redis_config['host']}:#{redis_config['port']}/0"
Sidekiq.configure_server do |config|
  config.options[:concurrency] = 30
  config.redis = { :namespace => 'sidekiq', :url => sidekiq_url }
end
Sidekiq.configure_client do |config|
  config.redis = { :namespace => 'sidekiq', :url => sidekiq_url }
end