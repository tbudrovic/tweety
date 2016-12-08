class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  protected
  def authenticate_user
    if user = authenticate_with_http_basic { |u, p| User.find_by(name: u).authenticate(p) }
      @current_user = user
    else
      head :unauthorized
    end
  end
end
