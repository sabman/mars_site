class RegionsController < ApplicationController
  before_filter :require_user, :except => [:show, :index]

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
end
