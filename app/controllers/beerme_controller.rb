class BeermeController < ApplicationController
	before_action :require_user_logged_in!
	def index
		$beerprice = File.open "beerprice.txt"
	end
end