class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Include our session helper
  include SessionsHelper

  # authentication
  def authenticate_user
  	unless current_user
      render :file => "public/401.html", :status => :unauthorized
  	end
  end
end
