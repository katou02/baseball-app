Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :tweets do
    resources :comments,only:[:create,:destroy]
    collection do
      get :search
    end
  end
  resources :tournaments,only:[:new,:create]
  resources :show,only:[:show]
  get '/top' => "top#index"
  # get 'users/:id' => 'users#show'
end
