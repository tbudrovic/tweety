class DocumentationController < ApplicationController
  def index
    render plain: "
     Prefix Verb   URI Pattern                          Controller#Action
            GET    /                                    documentation#index
     tweets GET    /api/tweets(.:format)                tweets#index
            POST   /api/tweets(.:format)                tweets#create
      tweet GET    /api/tweets/:id(.:format)            tweets#show
            PATCH  /api/tweets/:id(.:format)            tweets#update
            PUT    /api/tweets/:id(.:format)            tweets#update
            DELETE /api/tweets/:id(.:format)            tweets#destroy
user_tweets GET    /api/users/:user_id/tweets(.:format) tweets#index
      users GET    /api/users(.:format)                 users#index
            POST   /api/users(.:format)                 users#create
       user GET    /api/users/:id(.:format)             users#show
            PATCH  /api/users/:id(.:format)             users#update
            PUT    /api/users/:id(.:format)             users#update
            DELETE /api/users/:id(.:format)             users#destroy
"
  end
end
