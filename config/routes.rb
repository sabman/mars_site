ActionController::Routing::Routes.draw do |map|
  map.root :controller => "regions"
  map.resources :ga_users
  map.login "login",  :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.resources :user_sessions, :users
  map.resources :sampledata
  map.resources :samples
  map.resources :surveys, :shallow => true do |surveys|
    surveys.resources :samples do |sample| 
      sample.resources :sampledata
    end
  end
  map.resources :regions
  map.resources :surveys, :has_many => :samples
  map.resource :account, :controller => "users"
end
