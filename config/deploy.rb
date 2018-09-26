# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "thegamar-aio"
set :repo_url, "git@github.com:eiwi1101/thegamar-2"

set :deploy_to, "/var/app"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

append :linked_dirs, "log", "tmp", "node_modules", "web/js/node_modules", "vendor/bundle"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :procfile_roles, %w[web game]
set :procfile_use_sudo, false
set :procfile_options, {
    export_format: :systemd,
    export_path: "/etc/systemd/system",
    working_dir: release_path,
    log_dir: File.join(release_path, "log"),
    base_port: 5000,
    app_name: fetch(:application),
    user: nil,
    formation: "all=1"
}
