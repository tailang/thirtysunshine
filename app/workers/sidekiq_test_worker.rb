#encoding:utf-8
class SidekiqTestWorker
  include Sidekiq::Worker

  def perform(arg1,arg2)
    sleep(50)
    10.times do |i|
      puts "#{i}===#{arg1}=====#{arg2}"
    end
  end

end