ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
class SamplesController < ApplicationController
  before_filter :require_user, :except => [:show, :index] 

  resource_controller

  belongs_to :survey

  index.before do
    @missing_geom_samples ||= parent_object.samples_missing_metadata("geom") if parent?
  end
  index do 
    wants.json {}
  end

  show do 
    wants.json {}
  end


private

  def collection
    @collection ||= end_of_association_chain.paginate(:order => "entrydate DESC", :page => params[:page])
  end

  def object
    @object ||= Sample.find(params[:id])
  end


end
