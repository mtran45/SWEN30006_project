class SessionsController < ApplicationController

  # Before actions to check paramters
  before_action :check_params, only: [:login]
  before_action :authenticate_user, only: [:logout]

  def unauth
  end

  # Find a user with the username and password pair, log in that user if they exist
  def login
  	# Find a user with params
  	user = User.authenticate(@credentials[:password], @credentials[:username])
  	if user
	  	# Save them in the session
	  	log_in user
	  	# Redirect to articles page
	  	redirect_to articles_path
	else
		redirect_to :back, status: :created
	end
  end

  # Log out the user in the session and redirect to the unauth thing
  def logout
  	log_out
  	redirect_to login_path
  end

  # Private controller methods
  private
  def check_params
  	params.require(:credentials).permit(:password, :username)
  	@credentials = params[:credentials]
  end

end
