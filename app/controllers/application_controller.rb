class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  before_action :document_action

  protected
  def authenticate_user
    if user = authenticate_with_http_basic { |u, p| User.find_by(name: u).authenticate(p) }
      @current_user = user
    else
      head :unauthorized
    end
  end

  def document_action
    unless request.headers['User-Agent']
      browser = "Rails test suite"
    else
      browser = request.headers['User-Agent']
    end

    File.open(Rails.root.join('log', 'usage.log'), 'a+') { |file|
      file.write("#{request.fullpath}\t#{browser}\n")
    }
  end
end
