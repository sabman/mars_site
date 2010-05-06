class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if params[:id] == "current" 
      if current_user
        @user = current_user
      else
        flash[:notice] = "You need to be logged in to view this page."
        redirect_to login_url
      end
    else
      @user = User.find(params[:id])
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
