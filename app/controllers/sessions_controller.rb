class SessionsController < ApplicationController
	# Start loggin process
	def new
	end

	# Complete loggin process
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			redirect_to user
		else
			# Create an error message
			flash.now[:danger] = "Invalid email/password combination"	# Not quite right!
			render 'new'
		end
	end
	
	# Log out
	def destroy
		log_out
		redirect_to root_url
	end
end