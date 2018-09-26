namespace :procs do
  BASE = "/etc/systemd/system"
  PROCS = %w[web game]

  desc "Cleans up the Foreman mess and restarts procs."
  task :restart do
    on roles(:all) do
      PROCS.each do |proc|
        execute "mv #{BASE}/thegamar-aio-#{proc}@.service #{BASE}/thegamar-aio-#{proc}.service || true"
      end

      execute "systemctl daemon-reload"

      PROCS.each do |proc|
        execute "service thegamar-aio-#{proc} start"
      end
    end
  end

  desc "Stops tasks currently running."
  task :stop do
    on roles(:all) do
      PROCS.each do |proc|
        execute "service thegamar-aio-#{proc} stop || true"
      end
    end
  end

  desc "Clears old proc files."
  task :clean do
    on roles(:all) do
      execute "rm -rf #{BASE}/thegamar-aio*"
    end
  end
end

before :deploy, 'procs:stop'
before :deploy, 'procs:clean'
after :deploy, 'procs:restart'
