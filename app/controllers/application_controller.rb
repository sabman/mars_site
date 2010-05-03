# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base

  include ExceptionNotification::Notifiable
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  helper_method :current_user, :admin_is_logged_in?, :owner_is_logged_in?

  private


#  def require_owner(object)
#    if owner_is_logged_in?(object)
#      return true
#    else
#      flash[:notice] = "You do not have permissions"
#      redirect_back_or_default(root_url)
#      return false
#    end
#  end

  def owner_is_logged_in?(object)
    current_user && current_user.owns?(object)
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def require_admin_user
    if current_user && current_user.admin?
      return true
    elsif current_user && !current_user.admin?
      flash[:notice] = "Sorry, but you must be an administrator to access this page"
      redirect_to account_url
      return false
    else
      flash[:notice] = "You must be logged in and an administrator to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def admin_is_logged_in?
    current_user && current_user.admin?
  end

end
