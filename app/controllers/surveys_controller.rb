class SurveysController < ApplicationController
  before_filter :set_oracle_formats
  before_filter :require_user, :only => :upcoming
  before_filter :require_admin_user, :except => [:show, :index, :ran, :antarctica, :grain_size, :upcoming] 
  resource_controller

  show.wants.json { }
  index.wants.json{ }
  index.wants.js { }

  def update
    if object.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated!"
      redirect_to(object)
    else
      flash[:error] = "Problem updating"
      render :action => :edit
    end
  end

  def with_samples
    @surveys = Survey.find_by_sql("SELECT distinct (v.eno), v.surveyid, v.surveyname FROM surveys v, samples s where s.eno = v.eno order by v.eno")
  end

  def upcoming
    @survey = Survey.upcoming.first
    render :action => "show"
  end

  def ran
    @surveys = Survey.ran
  end

  def antarctica
    @surveys = Survey.antarctica
  end
    
  def grain_size
    render :haml => "grain_size", :layout => "table"
  end

  protected

  def model
    Survey
  end

  def collection
    #@collection ||= end_of_association_chain.paginate(:order => "entrydate DESC", :page => params[:page])
    @date = params[:date] || '1-Aug-2007'
    @collection ||= end_of_association_chain.recent(@date, :include => :samples).paginate(:page => params[:page], :per_page => 10, :order => "startdate DESC")
  end

  def object
    @object ||= end_of_association_chain.find(params[:id], :include => [:samples])
  end
  
  def set_oracle_formats
    ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
  end
end
