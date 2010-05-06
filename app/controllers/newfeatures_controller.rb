class NewfeaturesController < ApplicationController
  def index
    @newfeatures = %w{feature1 feature2 feature3}
  end
  
  def show
    @newfeatures = Newfeatures.find(params[:id])
  end
  
  def new
    @newfeatures = Newfeatures.new
  end
  
  def create
    @newfeatures = Newfeatures.new(params[:newfeatures])
    if @newfeatures.save
      flash[:notice] = "Successfully created newfeatures."
      redirect_to @newfeatures
    else
      render :action => 'new'
    end
  end
  
  def edit
    @newfeatures = Newfeatures.find(params[:id])
  end
  
  def update
    @newfeatures = Newfeatures.find(params[:id])
    if @newfeatures.update_attributes(params[:newfeatures])
      flash[:notice] = "Successfully updated newfeatures."
      redirect_to @newfeatures
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @newfeatures = Newfeatures.find(params[:id])
    @newfeatures.destroy
    flash[:notice] = "Successfully destroyed newfeatures."
    redirect_to newfeatures_url
  end
end
