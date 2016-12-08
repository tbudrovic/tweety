Rails.application.routes.draw do
  get "/" => "documentation#index"

  scope '/api' do
    resources :tweets
    
    resources :users do
      resources :tweets, only: [ :index ]
    end
  end
end
