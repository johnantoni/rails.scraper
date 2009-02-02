ActionController::Routing::Routes.draw do |map|

  map.connect '', :controller => 'scraper', :action => 'index'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
