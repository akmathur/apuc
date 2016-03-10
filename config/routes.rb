Apuc::Application.routes.draw do
  resources :profiles do
    match 'update_photo', :on => :member, :via => [:post, :put]
    match 'crop_canvas', :on => :member, :via => :get
  end

  root :to => "profiles#index"
end
