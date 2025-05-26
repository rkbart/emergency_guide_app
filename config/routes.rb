Rails.application.routes.draw do
  devise_for :users
  resources :emergency_contacts
  resources :checklists

  unauthenticated do
    root to: "home#home", as: :unauthenticated_root
  end

  authenticated :user do
    root to: "home#index", as: :authenticated_root
  end

  root to: "home#home"

  resources :favorites, only: [ :index ]

  resources :categories do
    resources :topics
  end


  resource :favorite, only: [ :create, :destroy ]

  resources :chat_ai, only: [ :index ] do
    collection do
      post :ask
      get :ask
    end
  end
end
