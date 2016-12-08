class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update ]
  before_action :authenticate_user, only: [ :update ]
  before_action :authorize_user, only: [ :update ]

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(password: user_params[:password])
      render json: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.permit(:name, :password)
  end

  def authorize_user
    unless @user == @current_user
      head :unauthorized
    end
  end
end
