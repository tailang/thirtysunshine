class RedmonWorker
  include Sidekiq::Worker

  def perform
    Redmon::Worker.new.record_stats
  ensure
    self.class.perform_in Redmon.config.poll_interval.seconds
  end
end