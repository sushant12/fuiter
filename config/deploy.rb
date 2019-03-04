# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "pageroo"
set :repo_url, "git@bitbucket.org:suss_buzz/fuitter.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, :'f-85'
# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/pageroo"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.5.3'
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
# set :nvm_type, :user # or :system, depends on your nvm setup
# set :nvm_node, 'v10.7.0'

# files we want symlinking to specific entries in shared
set :linked_files, %w[config/database.yml  config/master.key .env]

# dirs we want symlinking to shared
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]
set :bundle_binstubs, nil


namespace :deploy do
  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
end
# set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"