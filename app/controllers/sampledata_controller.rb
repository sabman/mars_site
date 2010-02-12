ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
class SampledataController < ApplicationController
  def index
    @sampledata = Sampledata.paginate(:page => params[:page], :per_page => 15)
    if request.xhr?
      render :partial => @sampledata
    end
  end
  
  def show
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
