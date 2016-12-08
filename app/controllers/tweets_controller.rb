class TweetsController < ApplicationController
  before_action :set_tweet, only: [ :show, :update, :destroy ]
  before_action :authenticate_user, only: [ :create, :update, :destroy ]
  before_action :authorize_user, only: [ :update, :destroy ]

  def index
    if params[:user_id]
      @tweets = User.find(params[:user_id]).tweets
    else
      @tweets = Tweet.all
    end

    render json: @tweets
  end

  def show
    render json: @tweet
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @current_user.tweets << @tweet

    if @tweet.save
      render json: @tweet, status: :created, location: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def update
    if @tweet.update(tweet_params)
      render json: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet.destroy
  end


  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.permit(:content)
  end

  def authorize_user
    unless @tweet.user == @current_user
      head :unauthorized
    end
  end
end
