class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user, 	   only: :destroy

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
	end

	def new
		@user = User.new	# Argument of form_for method
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
			flash[:info] = "Please check your email to activate your account."
			redirect_to root_url		# redirect to root page,
		else
			render 'new'
		end
	end

	def index
		@users = User.where(activated: true).paginate(page: params[:page])
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updateed"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password,
										 :password_confirmation)
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end
end