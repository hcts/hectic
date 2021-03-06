ActionController::Routing::Routes.draw do |map|
  map.resources :hosts do |host|
    host.resources :accounts, :shallow => true, :member => { :disable => :put, :enable => :put }
  end

  map.resources :network_interfaces, :member => { :tick => :put }

  map.root :controller => :dashboards
end
