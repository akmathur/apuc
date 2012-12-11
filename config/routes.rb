Apuc::Application.routes.draw do
  resources :profiles do
    post :update_photo, :on => :member
    get :refresh_photo, :on => :member
    get :replace_photo, :on => :member
    put :update_crop, :on => :member
  end

  root :to => "profiles#index"
end
