class ProfilesController < ApplicationController
	before_action :require_user_logged_in!
	def edit; end
	def update
		# user = Current.user
		if Current.user.update(profile_params)
		# if user.update(profile_params)
			redirect_to root_path, notice: 'Profile Updated'
		else
			render :edit
		end
	end
private
	def profile_params
		params.require(:user).permit(:username, :nickname)
	end
end