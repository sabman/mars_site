class RegionsController < ApplicationController
  def index
    @regions = Region.all
  end
  
  def show
    @region = Region.find(params[:id])
  end
  
  def new
    @region = Region.new
  end
  
  def create
    @region = Region.new(params[:region])
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
end
