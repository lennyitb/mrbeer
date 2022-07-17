class Admin::UserController < ApplicationController
	before_action :require_admin!
	def show
		@user = User.find(params[:user_id])
		@admin_enabled = @user.id == 1 or @user == Current.user
	rescue ActiveRecord::RecordNotFound
		# raise ActionController::RoutingError, 'Not Found'
		# render file: "#{Rails.root}/public/404.html",  status: 404
		not_found
	end

	def update_user
		user = User.find(params[:user_id])
		if user.update user_params
			redirect_to admin_path, notice: 'User updated'
		else
			render :show, notice: 'Failed to update user'
		end
	rescue
		not_found
	end

private
	def user_params
		params.require(:user).permit(:email, :admin, :price_percent, :min_price, :max_price, :max_outstanding_tab)
	end
end