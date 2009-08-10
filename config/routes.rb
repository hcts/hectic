ActionController::Routing::Routes.draw do |map|
  map.resources :hosts do |host|
    host.resources :accounts, :shallow => true
  end

  map.root :controller => :hosts
end
