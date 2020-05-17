Rails.application.routes.draw do
  devise_for :users
  root "tweets#index"
  resources :tweets
  resources :show,only:[:show]
  # get 'users/:id' => 'users#show'
end
