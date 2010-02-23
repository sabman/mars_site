set :application, "rhe-seismic"
set :rails_env, "production"

set :user, "sburq"
set :deploy_to,  "/d/mac/1/sburq/work/production/mars_site"
set :deploy_via, :copy
set :copy_exclude, [".git/*"]
set :copy_cache, "/d/mac/1/sburq/tmp/"
set :use_sudo, false

set :scm, :git
set :repository, "/d/mac/1/sburq/work/mars_site"
set :branch, "master"

role :web, application                          # Your HTTP server, Apache/etc
role :app, application                          # This may be the same as your `Web` server
role :db,  application, :primary => true        # This is where Rails migrations will run

namespace :deploy do
  desc "Tell nginx and thin to restart the app"
  task :restart do
    run "thin -C #{current_path}/config/thin/cluster_prod.yml restart"
    run "/d/mac/1/sburq/root/sbin/nginx -s reload"
  end

  desc "Symlink shared configs and folders on each release"
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end

  task :assets do
    system "rsync -vr --exclude "
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
