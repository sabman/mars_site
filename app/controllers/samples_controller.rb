#ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
class SamplesController < ApplicationController
  before_filter :require_admin_user, :except => [:show, :index] 

  resource_controller

  belongs_to :survey

  index do 
    wants.json {}
    wants.csv {}
    wants.kml {}
  end

  show.before do
    @comment = Comment.new(:commentable_type => "Sample", :commentable_id => @object.id)
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
    format = params[:format].downcase rescue nil
    if params[:region_id] # looking for samples within a region
      if format == "csv" || format == "kml" 
        @collection = Sample.find_all_by_region(Region.find(params[:region_id]))
      else
        geom = Region.find(params[:region_id]).to_geom
        conditions = Sample.bbox_search_conditions(geom)
        @collection = end_of_association_chain.paginate(:order => "entrydate DESC", :page => params[:page], :conditions => conditions)
      end
    elsif format == "csv" || format == "kml" 
      @collection = Sample.find(:all, :include => :survey, :conditions => {:eno => parent_object.eno})
    else
      @missing_geom_samples ||= parent_object.samples_missing_metadata("geom") if parent? 
      @collection ||= end_of_association_chain.paginate(:order => "entrydate DESC", :page => params[:page])
    end
  end

  def object
    @object ||= Sample.find(params[:id], :include => :sampledata)
  end


end
