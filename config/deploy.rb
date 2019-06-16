# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "fwitter"
set :repo_url, "git@github.com:sushant12/fuiter.git"

set :branch, :master
set :deploy_to, "/home/deploy/fwitter"

set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
# set :ssh_options,     forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa.pub]
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.5.3'
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
# set :nvm_type, :user # or :system, depends on your nvm setup
# set :nvm_node, 'v10.7.0'

# files we want symlinking to specific entries in shared
set :linked_files, %w[config/database.yml config/master.key .env config/sidekiq.yml]

# dirs we want symlinking to shared
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]
set :bundle_binstubs, nil


namespace :deploy do
  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
end

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch(:branch)}`
        puts "WARNING: HEAD is not the same as origin/#{fetch(:branch)}"
        puts 'Run `git push` to sync changes.'
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end