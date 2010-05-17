class EmailsController < ApplicationController
  def new
    render :new, :layout => 'thick_box'
  end
  
  def create
    if Mailer.deliver_feedback(params)
      flash[:notice] = "Thanks for the feedback! We will take action soon"
      render :text => "", :layout => 'thick_box'
    else
      render :action => 'new', :layout => 'thick_box'
    end
  end
end
