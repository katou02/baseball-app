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
      get :watch,:watch_avg,:watch_fcs
    end
  end
  resources :analyses do
    resources :comment_analyses,only:[:create,:destroy]
  end
  resources :forecasts,only:[:index,:new,:create,:destroy,:edit,:update]
  resources :tops,only:[:index]
  resources :mypages,only:[:show,:edit,:new,:create,:update,:index] do
    member do
      get :my_tweets,:my_analyses,:my_forecasts
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
  resources :messages, only: :create
  resources :rooms,only: [:create,:show]
  resources :contacts,only:[:index] do
    collection do
      post :check
      post :done
    end
  end
end