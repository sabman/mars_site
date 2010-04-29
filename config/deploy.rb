set :application, "localhost"
set :use_sudo, false
set :default_shell, "/bin/bash"

#ruby_bin = "/d/mac/1/sburq/.rvm/rubies/ruby-1.8.7-p249/bin"
#set :rake, "#{ruby_bin}/rake"

default_environment["ORACLE_HOME"] = "/usr/lib/oracle/10.2.0.3/client64"
default_environment["LD_LIBRARY_PATH"] = "/d/mac/1/sburq/root/opt/instantclient_11_2:/usr/lib/oracle/10.2.0.3/client64/lib:/d/mac/1/sburq/.rvm/usr/lib:/d/mac/1/sburq/root/lib"
default_environment["PATH"] = "/d/mac/1/sburq/.rvm/usr/bin:/d/mac/1/sburq/.rvm/bin:/d/mac/1/sburq/.rvm/rubies/ruby-1.8.7-p249/bin:/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/bin:/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249%global/bin:/d/mac/1/sburq/.rvm/bin:/usr/kerberos/bin:/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/usr/local/gmt/mbsystem-5.0.9/bin:/usr/local/GenericMappingTools/GMT4.1.3/bin:/usr/local/GenericMappingTools/netcdf-3.6.1/bin:/usr/local/ghostscript/gs5.50/bin:/d/mac/1/sburq/bin:/d/mac/1/sburq/root/bin"

set :user, "sburq"
set :deploy_to,  "/d/mac/1/sburq/work/production/mars_site"
set :deploy_via, :checkout
#set :copy_exclude, [".git/*"]
#set :copy_cache, "/d/mac/1/sburq/tmp/"

set :scm, :git
set :scm_command, "/d/mac/1/sburq/root/bin/git"
set :repository, "file:///d/mac/1/sburq/work/mars_site"
set :branch, "master"

role :web, application                          # Your HTTP server, Apache/etc
role :app, application                          # This may be the same as your `Web` server
role :db,  application, :primary => true        # This is where Rails migrations will run

namespace :deploy do
  desc "Make sure environment variables are setup"
  task :set_env do
  end

  desc "Tell nginx and thin to restart the app"
  task :restart do
    run "/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/bin/thin -C #{current_path}/config/thin/cluster_prod.yml restart"
    run "/d/mac/1/sburq/root/sbin/nginx -s reload"
  end

  desc "Symlink shared configs and folders on each release"
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/ldap_root_user.yml #{release_path}/config/ldap_root_user.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end

  task :assets do
    system "rsync -vr --exclude "
  end

end

after 'deploy:update_code', 'deploy:symlink_shared'
