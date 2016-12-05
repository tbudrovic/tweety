class UsersController < ApplicationController
  before_action :check_if_authorized, only: [ :update ]

  def create
    @user = User.new(filter_params)

    if @user.save
      head :created
    else
      head :bad_request
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(password: filter_params[:password])
      head :no_content
    else
      head :bad_request
    end
  end


  protected
  def filter_params
    params.permit(:name, :password)
  end
end
