ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
class SamplesController < ApplicationController
  before_filter :require_user, :except => [:show, :index] 

  resource_controller

  belongs_to :survey

  index do 
    wants.json {}
    wants.csv {}
  end

  show do 
    wants.json {}
  end

  update do 
    
  end


  def qc
  
  end

private

  def collection
    if params[:format] == "csv" 
      @collection = Sample.find(:all, :include => :survey, :conditions => {:eno => parent_object.eno})
    else
      @missing_geom_samples ||= parent_object.samples_missing_metadata("geom") if parent? 
      @collection ||= end_of_association_chain.paginate(:order => "entrydate DESC", :page => params[:page])
    end
  end

  def object
    @object ||= Sample.find(params[:id])
  end


end
