class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  protected
  def check_if_authorized
    if user = authenticate_with_http_basic { |u, p| User.find_by(name: u).authenticate(p) }
      @current_user = user
    else
      head :unauthorized
    end
  end
end
