ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
class SurveysController < ApplicationController
  before_filter :require_user, :except => [:show, :index, :ran, :antarctica] 
  resource_controller

  def update
    if object.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated!"
      redirect_to(object)
    else
      flash[:error] = "Problem updating"
      render :action => :edit
    end
  end

  def ran
    @surveys = Survey.ran
  end

  def antarctica
    @surveys = Survey.antarctica
  end
    
  protected

  def model
    Survey
  end

  def collection
    @collection ||= end_of_association_chain.paginate(:order => "entrydate DESC", :page => params[:page])
  end

  def object
    @object ||= end_of_association_chain.find(params[:id], :include => [:samples])
  end
end
