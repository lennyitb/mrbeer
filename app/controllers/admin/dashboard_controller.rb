class Admin::DashboardController < ApplicationController
	before_action	:require_admin!
	def index
		# $beerprice = File.open("beerprice.txt")
	end
	def change_price; end
	def update_price
		require_admin!
		# puts "form submitted:" << params[:new_price]
		finput = params[:new_price]
		if $beerprice.set finput
			redirect_to admin_path, notice: 'Updated price!'
		else
			redirect_to change_price_path, notice: 'Invalid price entered!'
		end
	end
end