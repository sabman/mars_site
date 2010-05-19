ActionController::Routing::Routes.draw do |map|
  map.upcoming_survey "/surveys/upcoming", :controller => :surveys, :action => :upcoming
  map.account "/account", :controller => :users, :action => :show, :id => "current"

  map.resources :emails

  map.resources :newfeatures

  map.resources :entities
  map.resources :quality_checks
  map.root :controller => "regions"
  map.resources :ga_users
  map.login "login",  :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.resources :user_sessions, :users
  map.resources :sampledata
  map.resources :samples, :has_many => :sampledata
  map.resources :surveys, :has_many => :samples, 
    :member => {
      :qc => :get, 
      :grain_size => :get
    }, 
    :collection => {
      :recent_marine  => :get,    # recent marine surveys
      :ran            => :get,    # surveys from RAN
      :antarctica     => :get     # surveys from antartica
    }
  map.resources :surveys, :shallow => true do |surveys|
    surveys.resources :samples do |sample| 
      sample.resources :sampledata
    end
  end
  map.resources :regions, :has_many => :samples, 
    :member => {
      :bbox => :get # So we can get a JSON representation of the region's bbox for query/display
    }
  map.resource :account, :controller => "users"
  map.resource :comments
  map.error "/error", :controller => :error, :action => :error
end
