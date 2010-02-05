class GaUsersController < ApplicationController
  def index
  end
  
  def show
  end
  
  def new
    @ga_user = GaUser.new
  end
  
  def create
    db_config = YAML.load_file("#{RAILS_ROOT}/config/database.yml")["oracle_production"]
    db_config["username"] = params[:username]
    db_config["password"] = params[:password]
    msg = GaUser.reset_connection(db_config)
    if GaUser.reset?
      flash[:notice] = msg
      redirect_to root_url
    else
      flash[:error] = msg
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
