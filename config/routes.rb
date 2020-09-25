Rails.application.routes.draw do
  root 'tweets#index'
  devise_for :users
  resources :tweets do
    resources :comments,only:[:create,:destroy]
    collection do
      get :search
    end
  end
  resources :show,only:[:show]
  resources :top,only:[:index]
  # get 'users/:id' => 'users#show'
end
