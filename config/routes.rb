ActionController::Routing::Routes.draw do |map|
  
  map.resource :account,:conditions => {:subdomain => false} do |a|
    a.resources :users
  end

  map.resources :users, :conditions => {:subdomain => true} 

  map.resource :user_session, :conditions => {:subdomain => true} 

  map.login '/login/', :controller => "user_sessions", :action => "new", :conditions => {:subdomain => /.+/}
  map.logout '/logout/', :controller => "user_sessions", :action => "destroy", :conditions => {:subdomain => /.+/}
  map.application_root "/", :controller => "main", :action => "index", :conditions => {:subdomain => /.+/}
  
  map.public_root "/", :controller => "public", :action => "index", :conditions => {:subdomain => nil}
  

end
