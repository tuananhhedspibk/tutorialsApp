class SessionsController < ApplicationController
	# Start loggin process
	def new
	end

	# Complete login process
	def create
<<<<<<< HEAD
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			if user.activated?
				log_in user
				# params[:session][:remember_me] == '1' ? remember(user) : forget(user)
				redirect_back_or user
			else
				message = "Account not activated. "
				message += "Check your email for the activation link."
				flash[:warning] = message
				redirect_to root_url
			end
=======
		@user = User.find_by(email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			log_in @user
			params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
			redirect_to @user
>>>>>>> advanced-login
		else
			# Create an error message
			flash.now[:danger] = "Invalid email/password combination"	# Not quite right!
			render 'new'
		end
	end
	
	# Log out
	def destroy
		log_out if logged_in?
		redirect_to root_url
	end
end