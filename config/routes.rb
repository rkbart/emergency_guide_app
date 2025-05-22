Rails.application.routes.draw do
  resources :categories do
    collection { post :import }
  end
  root "categories#index"
end
