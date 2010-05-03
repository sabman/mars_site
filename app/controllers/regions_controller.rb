class RegionsController < ApplicationController
  before_filter :require_owner, :only => [:delete, :edit]
  before_filter :require_user, :only => [:new, :create]

  def index
    @regions = Region.all
  end
  
  def show
    @region = Region.find(params[:id])
    @samples = @region.samples
  end
  
  def new
    @region = Region.new
  end
  
  def create
    @region = Region.new(params[:region])
    @region.user = current_user if current_user
    if @region.save
      flash[:notice] = "Successfully created region."
      redirect_to @region
    else
      render :action => 'new'
    end
  end
  
  def edit
    @region = Region.find(params[:id])
  end
  
  def update
    @region = Region.find(params[:id])
    if @region.update_attributes(params[:region])
      flash[:notice] = "Successfully updated region."
      redirect_to @region
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @region = Region.find(params[:id])
    @region.destroy
    flash[:notice] = "Successfully destroyed region."
    redirect_to regions_url
  end

  def bbox
    @region = Region.find(params[:id])
  end

  def require_owner
    @region = Region.find(params[:id])
    if owner_is_logged_in?(@region)
      return true
    else
      flash[:notice] = "Naughty naughty! You do not have permissions to do this"
      redirect_to region_path(@region)
      return false
    end
  end
end
