ActionController::Routing::Routes.draw do |map|
# this mysteriously stopped working: reenable when it starts working again.
#  map.root :controller => "family"
  map.root :controller => "default"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
