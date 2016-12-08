Rails.application.routes.draw do
  resources :tweets
  
  resources :users do
    resources :tweets, only: [ :index ]
  end
end
