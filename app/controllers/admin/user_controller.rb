class Admin::UserController < ApplicationController
	before_action :require_admin!
	def show
		# @user = User.find(params[:user_id])
		@user = find_user
		@admin_enabled = @user.id == 1 or @user == Current.user
	# rescue ActiveRecord::RecordNotFound
	# 	# raise ActionController::RoutingError, 'Not Found'
	# 	# render file: "#{Rails.root}/public/404.html",  status: 404
	# 	not_found
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

	def payment_page
		@user = find_user
	end

	def apply_payment
		@user = find_user
		finput = params[:payment_amount]
		if finput =~ /^(\$-|-\$|\$|-)?((\d{1,4}(\.\d{0,2})?)|(\.\d{1,2}))$/
			match = /^\$?(-)?\$?(\d+)$/.match finput
			filteramount = "#{match[1].to_s}#{match[2].to_s}".to_f.*(-1).to_s
			# @user.orders.create charge_amount: "#{match[1].to_s}#{match[2].to_s}"
			@user.orders.create charge_amount: filteramount
			redirect_to admin_path, notice: 'Payment successfully applied to ' << @user.email << '!'
		else
			redirect_to paymant_page_path, notice: 'Invalid amount entered!'
		end
	end

	def delete_user
		user = find_user
		uname = user.email
		user.destroy
		redirect_to admin_path, notice: 'Successfully deleted user '  << uname
	end

private
	def find_user
		User.find(params[:user_id])
	rescue ActiveRecord::RecordNotFound
		not_found
	end
	def user_params
		params.require(:user).permit(:email, :admin, :price_percent, :min_price, :max_price, :max_outstanding_tab)
	end
end