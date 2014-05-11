##请根据自己的环境修改

worker_processes 2

root = "/home/tailang/thirtysunshine/current"
working_directory root 

listen "/tmp/unicorn.thirtysunshine.sock", :backlog => 64

timeout 30

pid "#{root}/tmp/pids/unicorn.pid"

stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

   old_pid = "#{server.config[:pid]}.oldbin"
   if old_pid != server.pid
     begin
       sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
       Process.kill(sig, File.read(old_pid).to_i)
     rescue Errno::ENOENT, Errno::ESRCH
     end
   end
  
   sleep 1
end

after_fork do |server, worker|
   defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

 end
