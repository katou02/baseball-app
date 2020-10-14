Rails.application.routes.draw do
  root 'tweets#index'
  devise_for :users
  resources :tweets do
    resources :comments,only:[:create,:destroy]
    resources :likes,only:[:create,:destroy]
    collection do
      get :search
    end
  end
  resources :tournaments,only:[:show]
  resources :analyses,only:[:index,:new,:create]
  # resources :show,only:[:show]
  # resources :top,only:[:index]
end
