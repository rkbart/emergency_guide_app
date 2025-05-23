Rails.application.routes.draw do
  resources :chat_ai, only: [ :index ] do
    collection do
      post :ask
    end
  end
  root "home#index"

  resources :categories do
    collection do
      post :import
    end

    resources :topics
  end
end
