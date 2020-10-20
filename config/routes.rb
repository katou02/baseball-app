Rails.application.routes.draw do
  root 'tops#index'
  devise_for :users
  resources :tweets do
    resources :comments,only:[:create,:destroy]
    resources :likes,only:[:create,:destroy]
    collection do
      get :search
    end
  end
  resources :tournaments,only:[:show] do
    member do
      get "watch"
      get "watch_avg"
    end
  end
  resources :analyses,only:[:index,:new,:create,:destroy,:edit,:update]
  resources :forecasts,only:[:index,:new,:create,:destroy]
  resources :tops,only:[:index]
end
