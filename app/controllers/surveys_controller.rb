ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
class SurveysController < ApplicationController
  before_filter :require_user, :except => [:show, :index] 
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
    
  protected

  def model
    Survey
  end

  def collection
    @collection ||= end_of_association_chain.paginate(:order => "entrydate DESC", :page => params[:page])
  end

end
