Rails.application.routes.draw do
  devise_for :users
  resources :emergency_contacts
  resources :chat_ai, only: [ :index ] do
    collection do
      post :ask
      get :ask
    end
  end

  root "home#index"

  resources :categories do
    collection { post :import }

    resources :topics do
      collection { post :import }
    end
  end

  resources :checklists do
    collection do
      get :print
    end
  end
end
