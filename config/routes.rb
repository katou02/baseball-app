Rails.application.routes.draw do
  root 'tops#index'
  devise_for :users
  resources :tweets do
    collection do
      get :search
    end
    resources :comments,only:[:create,:destroy]
    resources :likes,only:[:create,:destroy]
  end
  resources :tournaments,only:[:show] do
    member do
      get "watch"
      get "watch_avg"
      get "watch_fcs"
    end
  end
  resources :analyses,only:[:index,:new,:create,:destroy,:edit,:update]
  resources :forecasts,only:[:index,:new,:create,:destroy,:edit,:update]
  resources :tops,only:[:index]
  resources :mypages,only:[:show,:edit,:new,:create,:update] do
    member do
      get "my_tweets"
      get "my_analyses"
      get "my_forecasts"
    end
  end
  namespace :admin do
    resources :users,only: [:index,:destroy] do
      collection do
        get :users_show
      end
    end
  end
  resources :users do
    member do
      get :following,:followers
    end
  end
  resources :relationships, only: [:create,:destroy]
  resources :notifications, only: :index
  resources :contacts,only:[:index] do
    collection do
      post :check
      post :done
    end
  end
end