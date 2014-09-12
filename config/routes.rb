Rails.application.routes.draw do
  root "gadgets#index"

  resources :gadgets do
    get 'flow', on: :collection
    
    resources :images
  end

  devise_for :users
end
