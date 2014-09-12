Rails.application.routes.draw do
  root "gadgets#index"

  resources :gadgets do
    resources :images
  end

  devise_for :users
end
