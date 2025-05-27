Rails.application.routes.draw do
  get "chats/show"
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

  resources :categories do
    collection { post :import }
    resources :topics do
      collection { post :import }
    end
  end

  resources :favorites, only: [ :index, :create, :destroy ]
  resources :chats, only: [ :create, :show ]

  resources :chat_ai, only: [ :index ] do
    collection do
      post :ask
      get :ask
    end
  end
end
