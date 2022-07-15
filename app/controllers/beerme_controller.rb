require "#{Rails.root}/lib/yourbeerprice.rb"

class BeermeController < ApplicationController
	include YourBeerPrice
	before_action :require_user_logged_in!
	def index
	end
end