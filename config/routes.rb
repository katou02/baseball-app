Rails.application.routes.draw do
  root "tweets#index"
  resources :tweets,only:[:index,:new,:create,:show,:destroy,:edit,:update]
end
