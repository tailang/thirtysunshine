require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, '121.199.47.65'
set :deploy_to, '/home/tailang/thirtysunshine'
set :app_path, "#{deploy_to}/current"
set :repository, 'tailang@121.199.47.65:thirtysunshine'
set :branch, 'master'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'config/initializers/secret_token.rb', 'log/unicorn.log', 'tmp/pids/unicorn.pid', 'public/uploads']

# Optional settings:
   set :user, 'tailang'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
   invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]
  queue! %[touch "#{deploy_to}/shared/log/unicorn.log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
  
  queue! %[mkdir -p "#{deploy_to}/shared/config/initializers"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config/initializers"]
  queue! %[touch "#{deploy_to}/shared/config/initializers/secret_token.rb"]
  queue  %[echo "-----> Be sure to edit 'shared/config/secret_token.rb'"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids"]
  queue! %[touch "#{deploy_to}/shared/tmp/pids/unicorn.pid"]

  queue! %[mkdir -p "#{deploy_to}/shared/public"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public"]
  queue! %[ln -s "/mnt/uploads" "#{deploy_to}/shared/public/"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile:force'

    to :launch do
      queue "touch #{deploy_to}/tmp/restart.txt"
    end
  end
end


#                                                                       Unicorn
# ==============================================================================
namespace :unicorn do
  set :unicorn_pid, "#{app_path}/tmp/pids/unicorn.pid"
  set :unicorn_pid_backup, "#{deploy_to}/tmp/unicorn_pid_backup"
  set :start_unicorn, %{
    cd #{app_path}
    unicorn -D -c config/unicorn.rb -E production
    cat "#{unicorn_pid}" > "#{unicorn_pid_backup}"
  }
 
#                                                                    Start task
# ------------------------------------------------------------------------------
  desc "Start unicorn"
  task :start => :environment do
    queue 'echo "-----> Start Unicorn"'
    queue! start_unicorn
  end
 
#                                                                     Stop task
# ------------------------------------------------------------------------------
  desc "Stop unicorn"
  task :stop do
    queue 'echo "-----> Stop Unicorn"'
    queue! %{
      test -s "#{unicorn_pid_backup}" && kill -9 `cat "#{unicorn_pid_backup}"` && echo "Stop Ok" && exit 0
      echo >&2 "Not running"
    }
  end
 
#                                                                  Restart task
# ------------------------------------------------------------------------------
  desc "Restart unicorn using 'upgrade'"
  task :restart => :environment do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end
