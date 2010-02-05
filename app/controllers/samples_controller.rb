ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
class SamplesController < ApplicationController
  before_filter :require_user, :except => [:show, :index] 

  resource_controller

  belongs_to :survey

  show.wants.json {}

  protected 

  def model
    Prod::Sample
  end

  def parent_object
    Prod::Survey.find(params[:survey_id])
  end

  def collection
    @collection ||= end_of_association_chain.paginate(:order => "entrydate DESC", :page => params[:page])
  end

  def object
    @object ||= Prod::Sample.find(params[:id])
  end
end
