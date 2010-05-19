class UserSessionsController < ApplicationController
  before_filter :check_for_email, :only => :create

  def new
    @user_session = UserSession.new
  end
  
  def create
    user = User.find_or_initialize_by_username(@username)
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
    redirect_back_or_default root_url 
  end
  
  private

  def check_for_email
    @username = params[:user_session][:username]
    if params[:user_session][:username] =~ /.*@ga.gov.au/ #email
      @username = User.find_ldap_username_by_email(params[:user_session][:username])
      if @username.nil?
        flash[:notice] = "Sorry but we couldn't not find a user by this email address."
        redirect_to login_path
        return false
      else
        return true
      end
    else #username
      return true
    end
  end

end
