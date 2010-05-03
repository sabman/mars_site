class EntitiesController < ApplicationController
  before_filter :require_admin_user, :except => [:show, :index] 
  def index
    @entities = Entity.all
  end
  
  def show
    @entity = Entity.find(params[:id])
  end
  
  def new
    #@entity = Entity.new
  end
  
  def create
    #@entity = Entity.new(params[:entity])
    #if @entity.save
    #  flash[:notice] = "Successfully created entity."
    #  redirect_to @entity
    #else
    #  render :action => 'new'
    #end
  end
  
  def edit
    #@entity = Entity.find(params[:id])
  end
  
  def update
    #@entity = Entity.find(params[:id])
    #if @entity.update_attributes(params[:entity])
    #  flash[:notice] = "Successfully updated entity."
    #  redirect_to @entity
    #else
    #  render :action => 'edit'
    #end
  end
  
  def destroy
    #@entity = Entity.find(params[:id])
    #@entity.destroy
    #flash[:notice] = "Successfully destroyed entity."
    #redirect_to entities_url
  end
end
