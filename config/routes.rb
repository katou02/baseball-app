Rails.application.routes.draw do
  root 'tops#index'
  devise_scope :user do
    post 'users/guest_sign_in',to: 'users/sessions#new_guest'
  end
  
  namespace :api,{format: 'json'} do
    namespace :v1 do
      post   'signups',  controller: :signups, action: :create
      post   'signin',  controller: :sessions, action: :create
      delete 'signin', controller: :sessions, action: :destroy
      post   'refresh', controller: :refresh,  action: :create

      resources :tweets do
        collection do
          get :category
        end
        resources :comments,only: [:create,:destroy,:index]
        resources :likes, only: [:index, :create, :destroy]
      end
      resources :users,only:[:index,:show,:edit,:update] do
        member do
          get :following,:followers
        end
      end
      resources :analyses do
        resources :comment_analyses,only: [:index,:create,:destroy]
      end
      resources :forecasts do
        resources :comment_forecasts,only: [:index,:create,:destroy]
      end
      resources :relationships, only: [:create,:destroy]
      resources :maps
      resources :messages,only: :create
      resources :champions,only:[:show,:create,:destroy]
      resources :notifications, only: :index
      resources :rooms,only:[:index,:show,:create]
      resources :tops,only:[:index]
      resources :tournaments,only:[:show] do
        member do
          get :watch_ays
          get :watch_fcs
          get :watch_avg
        end
      end
      resources :contacts,only:[:index] do
        collection do
          post :check
        end
      end
    end
  end
  get '*path', to: 'tops#index'
end