Rails.application.routes.draw do
  devise_for :users
  root "tweets#index"
  resources :tweets do
    resources :comments,only:[:create,:destroy]
    collection do
      get :search
    end
  end
  resources :show,only:[:show]
  # get 'users/:id' => 'users#show'
end
