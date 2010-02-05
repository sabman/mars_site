require File.dirname(__FILE__) + '/../spec_helper'
 
describe GaUsersController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => GaUser.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    GaUser.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    GaUser.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(ga_user_url(assigns[:ga_user]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => GaUser.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    GaUser.any_instance.stubs(:valid?).returns(false)
    put :update, :id => GaUser.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    GaUser.any_instance.stubs(:valid?).returns(true)
    put :update, :id => GaUser.first
    response.should redirect_to(ga_user_url(assigns[:ga_user]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    ga_user = GaUser.first
    delete :destroy, :id => ga_user
    response.should redirect_to(ga_users_url)
    GaUser.exists?(ga_user.id).should be_false
  end
end
