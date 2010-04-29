class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  
  def create
    user = User.find_or_initialize_by_username(params[:user_session][:username])
    @user_session = UserSession.new(user)
    if user.authenticate_against_ga_ldap(params[:user_session][:password]) 
      user.save if user.id.blank?
      @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_back_or_default root_url
    else
      flash[:notice] = "Incorrect login or password"
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
