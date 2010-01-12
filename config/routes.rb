ActionController::Routing::Routes.draw do |map|
  map.root :controller => "surveys", :action => "index"
  map.login "login",  :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.resources :user_sessions, :users
  map.resources :samples
  map.resources :sampledata
  map.resources :surveys, :shallow => true do |surveys|
    surveys.resources :samples do |sample| 
      sample.resources :sampledata
    end
  end

end
