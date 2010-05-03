ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
class SampledataController < ApplicationController
  before_filter :require_admin_user, :except => [:show, :index] 
  def index
    if params[:sample_id]
      @sample = Sample.find(params[:sample_id], :include=>[:survey, :sampledata])
      @sampledata = @sample.sampledata.paginate(:page => params[:page], :per_page => 15)
    else
      @sampledata = Sampledata.paginate(:page => params[:page], :per_page => 15)
    end
    if request.xhr?
      render :partial => @sampledata
    end
  end
  
  def show
    if params[:sample_id]
      @sample = Sample.find(params[:sample_id], :include => [:survey, :sampledata])
    end
    @sampledata = Sampledata.find(params[:id])
  end
  
  def new
    @sampledata = Sampledata.new
  end
  
  def create
    @sampledata = Sampledata.new(params[:sampledata])
    if @sampledata.save
      flash[:notice] = "Successfully created sampledata."
      redirect_to @sampledata
    else
      render :action => 'new'
    end
  end
  
  def edit
    @sampledata = Sampledata.find(params[:id])
  end
  
  def update
    @sampledata = Sampledata.find(params[:id])
    if @sampledata.update_attributes(params[:sampledata])
      flash[:notice] = "Successfully updated sampledata."
      redirect_to @sampledata
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @sampledata = Sampledata.find(params[:id])
    @sampledata.destroy
    flash[:notice] = "Successfully destroyed sampledata."
    redirect_to sampledata_url
  end
end
