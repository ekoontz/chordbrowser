ActionController::Routing::Routes.draw do |map|
  map.login "login", :controller => "user_sessions", :action => "new"
  map.login "logout", :controller => "user_sessions", :action => "destroy"

  map.resources :user_sessions
  map.resources :users

# this mysteriously stopped working: reenable when it starts working again.
#  map.root :controller => "family"
  map.root :controller => "default"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

#  map.connect '/foo',:url => 'bar'

end
