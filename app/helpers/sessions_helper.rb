module SessionsHelper

	# Logs in the given user.
	def log_in user
		session[:user_id] = user.id
	end

	def remember user
		user.remember	# generating a remember token and saving its digest to the database
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:rememeber_token] = user.remember_token
	end

	 # Returns the current logged-in user (if any).
	def current_user 
		if(user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif user_id = cookies.signed[:user_id] 
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:rememeber_token])
				log_in user
				@current_user = user
			end
		end	
	end

	def forget user
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:rememeber_token)
	end

	# Returns true if the user is logged in, false otherwise.
	def logged_in?
		!current_user.nil?
	end

	# Return true if given user is current user
	def current_user? user
		user == current_user
	end

	# Logs out the current user.
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	# Redirects to stored location (or to the default).
	def redirect_back_or default
		redirect_to(session[:forwarding_url] || default)
		# remove the forwarding URL
		session.delete(:forwarding_url)
	end

	def store_location
		# puts the requested URL in the session variable under the key :forwarding_url, but only for a GET request
		session[:forwarding_url] = request.original_url if request.get?
	end	
end