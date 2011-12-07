class ApplicationController < ActionController::Base

  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

    def require_user
      logger.debug "ApplicationController::require_user"
      unless current_user
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_session_path
        return false
      end
    end

  helper_method :current_user
end
