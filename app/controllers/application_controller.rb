class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def require_login
    authenticate_token || render_unauthorized("Access denied")
  end

  def current_user
    @current_user ||= authenticate_token
  end

  protected

  def render_unauthorized(message)
    errors = {errors: [ { detail:message} ] }
    render json: errors, status: :unauthorized
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token, options|
      User.find_by(token: api_token)
    end
  end
end
