Rails.application.routes.draw do
  devise_for :users
  resources :emergency_contacts

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
    # collection { post :import }
  end

  # resources :topics do
  #   collection { post :import }
  # end

  resource :favorite, only: [ :create, :destroy ]

  resources :chat_ai, only: [ :index ] do
    collection do
      post :ask
      get :ask
    end
  end

  resources :checklists do
    collection do
      get :print
    end
  end
end
