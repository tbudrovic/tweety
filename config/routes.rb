Rails.application.routes.draw do
  scope '/api' do
    resources :tweets
    
    resources :users do
      resources :tweets, only: [ :index ]
    end
  end
end
