require "#{Rails.root}/lib/yourbeerprice.rb"

class BeermeController < ApplicationController
	before_action :require_user_logged_in!
	def index
	end
	def beerme
		# Order.create user_id: Current.user.id, charge_amount: Current.price
		Current.user.orders.create charge_amount: Current.price
	end
end