Rails.application.routes.draw do
  root 'tops#index'
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in',to: 'users/sessions#new_guest'
  end
  resources :tweets do
    # collection do
    #   get :search
    # end
    resources :comments,only:[:create,:destroy]
    resources :likes,only:[:create,:destroy]
  end

  namespace :api,{format: 'json'} do
    namespace :v1 do
      resources :tweets,only:[:index,:show,:destroy] do
        collection do
          get :category
        end
        resources :comments,only: [:create,:destroy,:index]
        resources :likes, only: [:index, :create, :destroy]
      end
      resources :users,only:[:index]
      resources :analyses,only:[:index,:show] do
        collection do
          get :category
        end
        resources :comment_analyses,only: [:index,:create,:destroy]
      end
      resources :forecasts,only:[:index]
      resources :maps,only:[:index]
      resources :tournaments,only:[:show] do
        collection do
          get :category
        end
        member do
          get :watch_ays
          get :watch_fcs
        end
      end
    end
  end
  
  resources :tournaments,only:[:show] do
    member do
      get :watch_ays,:watch_avg,:watch_fcs
    end
  end
  resources :analyses do
    collection do
      get :search
    end
    resources :comment_analyses,only:[:create,:destroy]
  end
  resources :forecasts do
    collection do
      get :search
    end
    resources :comment_forecasts,only:[:create,:destroy]
  end
  resources :tops,only:[:index]
  namespace :admin do
    resources :users,only: [:index,:destroy] do
      collection do
        get :users_show
      end
    end
  end
  resources :users,only:[:index,:show,:edit,:update] do
    member do
      get :following,:followers
      get :likes
    end
  end
  resources :relationships, only: [:create,:destroy]
  resources :notifications, only: :index
  resources :messages, only: :create
  resources :rooms,only: [:index,:create,:show]
  resources :champions,only: [:new,:create,:destroy,:show]
  resources :maps,only: [:index,:new,:create,:edit,:update,:show,:destroy]
  resources :contacts,only:[:index] do
    collection do
      post :check
      post :done
    end
  end
end